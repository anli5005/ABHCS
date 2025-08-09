//
//  SaveToCalendarView.swift
//  ABHCS
//
//  Created by Anthony Li on 8/9/25.
//

#if os(iOS)

import SwiftUI
import UIKit
import EventKit
import EventKitUI

struct SaveToCalendarView {
    var event: ConferenceEvent
    var eventStore: EKEventStore
    
    @Environment(\.dismiss) var dismiss
    
    func setup(controller: EKEventEditViewController, coordinator: Coordinator) {
        controller.eventStore = eventStore
        controller.editViewDelegate = coordinator
    }
    
    func update(controller: EKEventEditViewController, coordinator: Coordinator) {
        if event != coordinator.event {
            coordinator.event = event
            let ekEvent = EKEvent(eventStore: eventStore)
            
            if let begin = event.begin {
                ekEvent.startDate = begin
            }
            
            if let end = event.end {
                ekEvent.endDate = end
            }
            
            ekEvent.title = event.title
            ekEvent.availability = .busy
            ekEvent.location = event.location
            ekEvent.isAllDay = false
            
            controller.event = ekEvent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, EKEventEditViewDelegate {
        var event: ConferenceEvent?
        var parent: SaveToCalendarView
        
        init(parent: SaveToCalendarView) {
            self.parent = parent
        }
        
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            parent.dismiss()
        }
    }
}

extension SaveToCalendarView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let controller = EKEventEditViewController()
        setup(controller: controller, coordinator: context.coordinator)
        update(controller: controller, coordinator: context.coordinator)
        return controller
    }
    
    func updateUIViewController(_ controller: EKEventEditViewController, context: Context) {
        update(controller: controller, coordinator: context.coordinator)
    }
}

#endif
