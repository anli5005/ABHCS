//  ConferenceScheduleViewModel.swift
//  ABHCS
//
//  Created by Assistant on 8/8/25.
//

import Foundation
import Observation

let timezone = TimeZone(identifier: "America/Los_Angeles")!

// MARK: - Models

struct ConferenceEvent: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let description: String
    let begin: Date?
    let end: Date?
    let location: String?
    let speakers: [Speaker]
    let tags: [Tag]
}

struct ConferenceEventStartGroup: Identifiable, Equatable {
    let id: Date // Start time of the group (rounded to minute in conference timezone)
    let events: [ConferenceEvent]

    static var allDayID: Date { Date.distantPast }
}

struct ConferenceEventDay: Identifiable, Equatable {
    let id: Date // Start of day (midnight, in the conference timezone)
    let startGroups: [ConferenceEventStartGroup]
}

struct Speaker: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    let affiliations: [String]
    let links: [SpeakerLink]
    let title: String?
}

struct SpeakerLink: Equatable, Hashable {
    let title: String
    let url: URL?
}

// MARK: - DTOs for decoding Firestore's response

fileprivate struct FirestoreQueryResponse: Decodable {
    let document: FirestoreDocument?
}

fileprivate struct FirestoreDocument: Decodable {
    let name: String
    let fields: [String: FirestoreValue]
}

fileprivate enum FirestoreValue: Decodable {
    case stringValue(String)
    case integerValue(String)
    case arrayValue(FirestoreArrayValue)
    case mapValue(FirestoreMapValue)
    case nullValue
    case timestampValue(String)

    struct FirestoreArrayValue: Decodable {
        let values: [FirestoreValue]?
    }
    struct FirestoreMapValue: Decodable {
        let fields: [String: FirestoreValue]
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let v = try? container.decode(String.self, forKey: .stringValue) {
            self = .stringValue(v)
        } else if let v = try? container.decode(String.self, forKey: .integerValue) {
            self = .integerValue(v)
        } else if let v = try? container.decode(FirestoreArrayValue.self, forKey: .arrayValue) {
            self = .arrayValue(v)
        } else if let v = try? container.decode(FirestoreMapValue.self, forKey: .mapValue) {
            self = .mapValue(v)
        } else if (try? container.decodeNil(forKey: .nullValue)) == true {
            self = .nullValue
        } else if let v = try? container.decode(String.self, forKey: .timestampValue) {
            self = .timestampValue(v)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: decoder.codingPath, debugDescription: "Unknown Firestore value type"))
        }
    }

    enum CodingKeys: String, CodingKey {
        case stringValue, integerValue, arrayValue, mapValue, nullValue, timestampValue
    }
}

// MARK: - Mapper utilities

fileprivate extension FirestoreDocument {
    var eventID: String {
        name.components(separatedBy: "/").last ?? name
    }

    func toConferenceEvent() -> ConferenceEvent? {
        guard let title = fields["title"]?.string,
              let description = fields["description"]?.string else { return nil }
        let begin = fields["begin_tsz"]?.string.flatMap { ISO8601DateFormatter().date(from: $0) }
        let end = fields["end_tsz"]?.string.flatMap { ISO8601DateFormatter().date(from: $0) }
        let location = fields["location"]?.mapValue?.fields["name"]?.string
        let speakers = fields["speakers"]?.arrayValue?.values?.compactMap { $0.speaker } ?? []
        let tagIDs = fields["tag_ids"]?.arrayValue?.values?.compactMap { $0.int } ?? []
        let tags = tagIDs.compactMap { tagDict[$0] }
        return ConferenceEvent(
            id: eventID,
            title: title,
            description: description,
            begin: begin,
            end: end,
            location: location,
            speakers: speakers,
            tags: tags
        )
    }
}

fileprivate extension FirestoreValue {
    var string: String? {
        if case let .stringValue(val) = self { return val } else { return nil }
    }
    var int: Int? {
        if case let .integerValue(val) = self { return Int(val) } else { return nil }
    }
    var arrayValue: FirestoreValue.FirestoreArrayValue? {
        if case let .arrayValue(val) = self { return val } else { return nil }
    }
    var mapValue: FirestoreValue.FirestoreMapValue? {
        if case let .mapValue(val) = self { return val } else { return nil }
    }
    var speaker: Speaker? {
        guard let fields = self.mapValue?.fields,
              let id = fields["id"]?.int,
              let name = fields["name"]?.string else { return nil }
        let affiliations = fields["affiliations"]?.arrayValue?.values?.compactMap {
            $0.mapValue?.fields["title"]?.string
        } ?? []
        let links = fields["links"]?.arrayValue?.values?.compactMap { val in
            guard case let .mapValue(linkMapValue) = val,
                  let title = linkMapValue.fields["title"]?.string else { return nil }
            let url = linkMapValue.fields["url"]?.string.flatMap { URL(string: $0) }
            return SpeakerLink(title: title, url: url)
        } ?? [SpeakerLink]()
        let title = fields["title"]?.string
        return Speaker(id: String(id), name: name, affiliations: affiliations, links: links, title: title)
    }
}

// MARK: - @Observable ViewModel

@Observable
class ConferenceScheduleViewModel {
    private(set) var events: [ConferenceEvent] = []
    private(set) var days: [ConferenceEventDay] = []
    private(set) var isLoading = false
    private(set) var error: Error?

    func load() async {
        error = nil
        isLoading = true
        defer { isLoading = false }
        guard let url = URL(string: "https://firestore.googleapis.com/v1/projects/junctor-hackertracker/databases/(default)/documents/conferences/DEFCON33:runQuery") else {
            error = URLError(.badURL)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.httpBody = "{\"structuredQuery\":{\"from\":[{\"collectionId\":\"events\"}],\"orderBy\":[{\"field\":{\"fieldPath\":\"begin_timestamp\"},\"direction\":\"ASCENDING\"},{\"field\":{\"fieldPath\":\"__name__\"},\"direction\":\"ASCENDING\"}]}}".data(using: .utf8)
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let results = try decoder.decode([FirestoreQueryResponse].self, from: data)
            self.events = results.compactMap { $0.document?.toConferenceEvent() }

            // Group events by day in the specified timezone.
            let calendar = Calendar(identifier: .gregorian)
            var grouped: [Date: [ConferenceEvent]] = [:]
            for event in self.events {
                guard let begin = event.begin else { continue }
                let dayStart = calendar.date(from: calendar.dateComponents(in: timezone, from: begin).settingHourMinuteSecond(0, 0, 0))!
                grouped[dayStart, default: []].append(event)
            }
            self.days = grouped.keys.sorted().map { day in
                let dayEvents = grouped[day] ?? []
                
                // Filter allDayEvents (duration > 5 hours)
                let allDayEvents = dayEvents.filter { event in
                    if let begin = event.begin, let end = event.end {
                        return end.timeIntervalSince(begin) > 7 * 3600
                    }
                    return false
                }

                var timeGroups: [Date: [ConferenceEvent]] = [:]
                // Exclude allDayEvents from time groups
                let filteredEvents = dayEvents.filter { !allDayEvents.contains($0) }
                for event in filteredEvents {
                    guard let begin = event.begin else { continue }
                    let comps = calendar.dateComponents(in: timezone, from: begin)
                    var startComps = comps
                    startComps.second = 0
                    startComps.nanosecond = 0
                    let startTime = calendar.date(from: startComps)!
                    timeGroups[startTime, default: []].append(event)
                }
                var startGroups = timeGroups.keys.sorted().map { time in
                    ConferenceEventStartGroup(id: time, events: timeGroups[time]?.sorted(by: { lhs, rhs in
                        if let lhs = lhs.eventCategory, let rhs = rhs.eventCategory {
                            return lhs < rhs
                        }
                        
                        let lhsHasCategory = lhs.eventCategory != nil
                        let rhsHasCategory = rhs.eventCategory != nil
                        if lhsHasCategory != rhsHasCategory {
                            // Events with a category come first
                            return lhsHasCategory && !rhsHasCategory
                        }
                        
                        return lhs.id < rhs.id
                    }) ?? [])
                }
                
                if !allDayEvents.isEmpty {
                    let allDayGroup = ConferenceEventStartGroup(id: ConferenceEventStartGroup.allDayID, events: allDayEvents.sorted(by: { lhs, rhs in
                        if let lhs = lhs.eventCategory, let rhs = rhs.eventCategory {
                            return lhs < rhs
                        }
                        
                        let lhsHasCategory = lhs.eventCategory != nil
                        let rhsHasCategory = rhs.eventCategory != nil
                        if lhsHasCategory != rhsHasCategory {
                            // Events with a category come first
                            return lhsHasCategory && !rhsHasCategory
                        }
                        
                        return lhs.id < rhs.id
                    }))
                    startGroups.insert(allDayGroup, at: 0)
                }
                
                return ConferenceEventDay(id: day, startGroups: startGroups)
            }
        } catch {
            self.error = error
        }
    }
}

extension DateComponents {
    func settingHourMinuteSecond(_ hour: Int, _ minute: Int, _ second: Int) -> DateComponents {
        var comps = self
        comps.hour = hour
        comps.minute = minute
        comps.second = second
        comps.nanosecond = 0
        return comps
    }
}

extension ConferenceEvent {
    var eventCategory: Tag? {
        tags.first(where: { $0.type == .eventCategory })
    }
}
