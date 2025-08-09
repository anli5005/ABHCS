//
//  EventInspector.swift
//  ABHCS
//
//  Created by Anthony Li on 8/8/25.
//

import SwiftUI
import EventKit

#if os(macOS)
let textColor = Color(NSColor.textColor)
#else
let textColor = Color(UIColor.label)
#endif

struct EventInspector: View {
    var event: ConferenceEvent
    var eventStore: EKEventStore
    
    @State var isAddingEvent = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Text(event.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(event.tags) { tag in
                        HStack(alignment: .firstTextBaseline) {
                            Circle()
                                .fill(tag.color)
                                .frame(width: 10, height: 10)
                            Text(tag.label)
                        }
                    }
                }
                .padding(.top, 8)
                
                if let location = event.location {
                    VStack(alignment: .leading, spacing: 4) {
                        if let begin = event.begin {
                            HStack(alignment: .top) {
                                Image(systemName: "calendar")
                                Text("\(begin, format: Date.FormatStyle(date: .long))")
                            }
                        }
                        
                        if let begin = event.begin, let end = event.end {
                            HStack(alignment: .top) {
                                Image(systemName: "clock")
                                Text("\(begin, format: Date.FormatStyle(time: .shortened))–\(end, format: Date.FormatStyle(time: .shortened))")
                            }
                        }
                        
                        HStack(alignment: .top) {
                            Image(systemName: "map")
                            Text(location)
                        }
                    }
                    .padding(.top, 16)
                }
                
                #if os(iOS)
                Group {
                    if #available(iOS 26.0, *) {
                        Button {
                            isAddingEvent = true
                        } label: {
                            Label("Add to Calendar", systemImage: "calendar.badge.plus")
                                .fontWeight(.medium)
                        }
                        .buttonStyle(.glassProminent)
                    } else {
                        Button {
                            isAddingEvent = true
                        } label: {
                            Label("Add to Calendar", systemImage: "calendar.badge.plus")
                                .fontWeight(.medium)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                .buttonBorderShape(.capsule)
                .tint(.red)
                .padding(.top, 16)
                #endif
                
                let attrStr = (try? AttributedString(markdown: event.description, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))) ?? AttributedString(event.description)
                
                Text(attrStr)
                    .padding(.top, 16)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            #if os(iOS)
            .sheet(isPresented: $isAddingEvent) {
                SaveToCalendarView(event: event, eventStore: eventStore)
            }
            #endif
        }
    }
}

#Preview {
    @Previewable @State var eventStore = EKEventStore()
    
    Rectangle()
        .fill(.clear)
        .frame(width: 100, height: 400)
        .inspector(isPresented: .constant(true)) {
            NavigationStack {
                EventInspector(event: ConferenceEvent(
                    id: "mock1",
                    title: "Mock Event",
                    description: "A sample event for preview.\n\nHi!",
                    begin: Date(),
                    end: Date().advanced(by: 3600),
                    location: "Mock Room 1",
                    speakers: [],
                    tags: [Tag(type: .eventCategory, id: 48011, label: "Event", backgroundColor: "#8248f8", foregroundColor: "#ffffff", iconName: "calendar")]
                ), eventStore: eventStore)
            }
            .foregroundStyle(textColor)
        }
}
