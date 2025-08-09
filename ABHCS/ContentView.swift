import SwiftUI

struct SectionHeaderView: View {
    var content: LocalizedStringKey
    
    init(_ content: LocalizedStringKey) {
        self.content = content
    }
    
    var body: some View {
        Text(content)
            .fontWeight(.bold)
            .font(.headline)
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SearchDescriptor: Equatable {
    var searchText: String
    var searchTokens: [SearchToken]
}

struct ContentView: View {
    @State private var viewModel = ConferenceScheduleViewModel()
    @State private var selectedDayIndex: Int = 0
    
    @State private var isPresentingInspector = false
    @State private var selectedEvent: ConferenceEvent?
    
    @State private var searchText = ""
    @State private var searchTokens = [SearchToken]()
    @State private var searchResults = [SearchSection]()
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func presentEvent(event: ConferenceEvent) {
        isPresentingInspector = true
        selectedEvent = event
    }
    
    var isSearching: Bool {
        !searchText.isEmpty || !searchTokens.isEmpty
    }
    
    @ViewBuilder var stackContent: some View {
        if isSearching {
            if horizontalSizeClass == .compact {
                let tokens = suggestedTokens(text: searchText).filter { !searchTokens.contains($0) }
                
                if !tokens.isEmpty {
                    Section(header: SectionHeaderView("Filter Suggestions")) {
                        ForEach(tokens) { token in
                            Button {
                                searchTokens.append(token)
                                searchText = ""
                            } label: {
                                HStack(alignment: .top) {
                                    token
                                    Spacer()
                                }
                                .padding(4)
                                .background(.tint.opacity(0.3))
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                                .lineLimit(1)
                                .foregroundStyle(.tint)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            
            ForEach(searchResults) { group in
                Section(header: SectionHeaderView("\(group.id.formatted(date: .complete, time: .omitted))")) {
                    ForEach(group.events) { event in
                        Button {
                            presentEvent(event: event)
                        } label: {
                            ConferenceEventRowView(event: event, showStartTime: true)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        } else {
            if !viewModel.days.isEmpty, selectedDayIndex < viewModel.days.count {
                let groups = viewModel.days[selectedDayIndex].startGroups
                if let firstGroup = groups.first, firstGroup.id == ConferenceEventStartGroup.allDayID {
                    Section(header: SectionHeaderView("All-Day")) {
                        ForEach(firstGroup.events) { event in
                            Button {
                                presentEvent(event: event)
                            } label: {
                                ConferenceEventRowView(event: event, showStartTime: true)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                
                ForEach(groups.dropFirst().filter { $0.id != ConferenceEventStartGroup.allDayID }) { group in
                    Section(header: SectionHeaderView("\(group.id.formatted(date: .omitted, time: .shortened))")) {
                        ForEach(group.events) { event in
                            Button {
                                presentEvent(event: event)
                            } label: {
                                ConferenceEventRowView(event: event, showStartTime: true)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
    }

    var body: some View {
        NavigationStack(path: Binding<[ConferenceEvent]> {
            if horizontalSizeClass == .compact {
                if let selectedEvent, isPresentingInspector {
                    return [selectedEvent]
                } else {
                    return []
                }
            } else {
                return []
            }
        } set: { path in
            if let event = path.last {
                isPresentingInspector = true
                selectedEvent = event
            } else {
                isPresentingInspector = true
                selectedEvent = nil
            }
        }) {
            ScrollView {
                LazyVStack {
                    if viewModel.isLoading {
                        ProgressView()
                    } else if let error = viewModel.error {
                        Text("Error: \(error.localizedDescription)")
                    } else {
                        stackContent
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .task {
                if viewModel.days.isEmpty {
                    await viewModel.load()
                } else {
                    selectedDayIndex = 0
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    if !viewModel.days.isEmpty {
                        Picker("Day", selection: $selectedDayIndex) {
                            ForEach(Array(viewModel.days.enumerated()), id: \.element.id) { (idx, day) in
                                Text(day.id.formatted(Date.FormatStyle(date: .abbreviated, time: .none).weekday(.short).month(.omitted).year(.omitted))).tag(idx)
                            }
                        }
                        .pickerStyle(.segmented)
                        .disabled(isSearching)
                    }
                }
            }
            .navigationDestination(for: ConferenceEvent.self) { event in
                EventInspector(event: event)
            }
            .inspector(isPresented: Binding {
                isPresentingInspector && horizontalSizeClass != .compact
            } set: {
                if horizontalSizeClass != .compact {
                    isPresentingInspector = $0
                }
            }) {
                Group {
                    if let selectedEvent {
                        EventInspector(event: selectedEvent)
                    } else {
                        Text("Select an event to view its details.")
                            .padding()
                    }
                }
                .foregroundStyle(textColor)
            }
            .inspectorColumnWidth(min: 400, ideal: 500, max: 700)
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .searchable(text: $searchText, tokens: $searchTokens, token: { $0 })
            .searchSuggestions {
                if isSearching, horizontalSizeClass != .compact {
                    ForEach(suggestedTokens(text: searchText)) { token in
                        token.searchCompletion(token)
                    }
                }
            }
            .onChange(of: SearchDescriptor(searchText: searchText, searchTokens: searchTokens)) {
                if isSearching {
                    searchResults = search(events: viewModel.events, text: searchText, tokens: searchTokens)
                }
            }
        }
    }
}

#Preview {
    Text("Run the app")
        .padding()
}
