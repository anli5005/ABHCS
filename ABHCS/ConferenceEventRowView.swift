//
//  ConferenceEventRowView.swift
//  ABHCS
//
//  Created by Anthony Li on 8/8/25.
//

import SwiftUI

struct DetailFragmentView: View {
    var image: Image
    var text: Text
    
    var body: some View {
        HStack(spacing: 4) {
            image
            text
        }
        .font(.caption)
    }
}

struct ConferenceEventRowView: View {
    var event: ConferenceEvent
    var showStartTime = false
    
    var shapeStyle: some ShapeStyle {
        if let color = event.eventCategory?.color {
            AnyShapeStyle(color)
        } else {
            AnyShapeStyle(.primary)
        }
    }
    
    var time: Text? {
        if showStartTime, let start = event.begin, let end = event.end {
            Text("\(start.formatted(date: .omitted, time: .shortened))–\(end.formatted(date: .omitted, time: .shortened))")
        } else if let end = event.end {
            Text("ends \(end.formatted(date: .omitted, time: .shortened))")
        } else {
            nil
        }
    }
    
    var detailTag: Tag? {
        TagType.detailTypes.lazy.compactMap { type in
            event.tags.first { $0.type == type }
        }.first
    }

    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .fill(shapeStyle)
                .frame(width: 20, height: 20)
                .overlay {
                    Image(systemName: event.eventCategory?.iconName ?? "circle.fill")
                        .blendMode(.destinationOut)
                        .imageScale(.small)
                }
                .compositingGroup()
            
            VStack(alignment: .leading) {
                Text(event.title)
                
                HStack {
                    if let time {
                        DetailFragmentView(image: .init(systemName: "clock"), text: time)
                    }
                    
                    if let detailTag {
                        DetailFragmentView(image: .init(systemName: detailTag.type.iconName), text: Text("\(detailTag.label)"))
                    }
                }
                .foregroundStyle(.secondary)
            }
            .padding(.top, 2)
            
            Spacer()
        }
        .padding(4)
        .background(shapeStyle.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .lineLimit(1)
    }
}

#Preview {
    ConferenceEventRowView(event: ConferenceEvent(
        id: "mock1",
        title: "Mock Event",
        description: "A sample event for preview.",
        begin: Date(),
        end: Date().advanced(by: 3600),
        location: "Mock Room 1",
        speakers: [],
        tags: [Tag(type: .eventCategory, id: 48011, label: "Event", backgroundColor: "#8248f8", foregroundColor: "#ffffff", iconName: "calendar")]
    ))
    .frame(width: 400)
    .padding()
}
