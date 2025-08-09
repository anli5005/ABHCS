//
//  EventInspector.swift
//  ABHCS
//
//  Created by Anthony Li on 8/8/25.
//

import SwiftUI

#if os(macOS)
let textColor = Color(NSColor.textColor)
#else
let textColor = Color(UIColor.label)
#endif

struct EventInspector: View {
    var event: ConferenceEvent
    
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
                    HStack(alignment: .top) {
                        Image(systemName: "map")
                        Text(location)
                    }
                    .padding(.top, 16)
                }
                
                Group {
                    if let attrStr = try? AttributedString(markdown: event.description, options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)) {
                        Text(attrStr)
                            .textSelection(.enabled)
                    } else {
                        Text(event.description)
                            .textSelection(.enabled)
                    }
                }
                .padding(.top, 16)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
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
                ))
            }
            .foregroundStyle(textColor)
        }
}
