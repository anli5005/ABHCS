//
//  Search.swift
//  ABHCS
//
//  Created by Anthony Li on 8/8/25.
//

import SwiftUI

enum SearchToken: Identifiable, Equatable, Hashable, View {
    var id: SearchToken {
        self
    }
    
    case tag(Tag)
    
    @ViewBuilder var body: some View {
        switch self {
        case .tag(let tag):
            HStack {
                Image(systemName: "tag")
                Text(tag.label)
            }
        }
    }
}

struct SearchSection: Identifiable, Equatable {
    let id: Date
    let events: [ConferenceEvent]
}

func suggestedTokens(text: String) -> [SearchToken] {
    return tagDict.values.sorted(by: { $0.id < $1.id }).filter {
        $0.label.lowercased().contains(text.lowercased())
    }.map { .tag($0) }
}

func search(events: [ConferenceEvent], text: String, tokens: [SearchToken]) -> [SearchSection] {
    let filteredEvents = events.filter { event in
        let satisfiesTokens = tokens.allSatisfy { token in
            switch token {
            case .tag(let tag):
                return event.tags.contains(tag)
            }
        }
        
        if !satisfiesTokens {
            return false
        }
        
        let query = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if text.isEmpty { return true }
        let inTitle = event.title.lowercased().contains(query)
        let inTags = event.tags.contains { $0.label.lowercased().contains(query) }
        let inLocation = event.location?.lowercased().contains(query) ?? false
        let inSpeakers = event.speakers.contains { $0.name.lowercased().contains(query) }
        return inTitle || inTags || inLocation || inSpeakers
    }
    
    var grouped: [Date: [ConferenceEvent]] = [:]
    let calendar = Calendar(identifier: .gregorian)
    for event in filteredEvents {
        guard let begin = event.begin else { continue }
        let dayStart = calendar.date(from: calendar.dateComponents(in: timezone, from: begin).settingHourMinuteSecond(0, 0, 0))!
        grouped[dayStart, default: []].append(event)
    }
    
    return grouped.keys.sorted().map { day in
        let dayEvents = grouped[day] ?? []
        return SearchSection(id: day, events: dayEvents)
    }
}
