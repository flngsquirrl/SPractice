//
//  ExerciseSelectionView.swift
//  SPractice
//
//  Created by Yuliya Charniak on 8.06.22.
//

import SwiftUI

struct ExerciseSelectionView: View {
    
    enum ItemsGroup: String, CaseIterable {
        case all
        case prepared
    }
    
    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    
    private var onAdd: ([ExerciseTemplate]) -> Void
    
    init(onAdd: @escaping ([ExerciseTemplate]) -> Void) {
        self.onAdd = onAdd
    }
    
    func onDelete(_ indexSet: IndexSet) {
        viewModel.onDeleteSelectionItem(at: indexSet)
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(viewModel.sortedElements) { item in
                        SelectionRow(item: item, isAdded: viewModel.itemsGroup == .prepared) {
                                viewModel.onChange($0, counter: $1)
                            }
                    }
                    .onDelete(perform: viewModel.itemsGroup == .prepared ? onDelete : nil)
                } header: {
                    HStack {
                        Text(viewModel.headerText)
                        if viewModel.itemsGroup == .prepared {
                            Spacer()
                            Button("Clear") { viewModel.deleteFiltered() }
                                .disabled(viewModel.filteredElements.isEmpty)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer)
            .disableAutocorrection(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Group of templates", selection: $viewModel.itemsGroup) {
                        ForEach(ItemsGroup.allCases, id: \.self) { group in
                            Image(systemName: getImageName(for: group))
                        }
                    }
                    .fixedSize()
                    .pickerStyle(.segmented)
                }
                    
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        onAdd(viewModel.exercises)
                        dismiss()
                    }
                    .disabled(viewModel.filteredElements.isEmpty)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .accentColor(.customAccentColor)
    }
    
    func getImageName(for group: ItemsGroup) -> String {
        switch group {
        case .all:
            return "list.bullet"
        case .prepared:
            return "checkmark"
        }
    }
    
    struct SelectionItem: Identifiable, Named {
        var template: ExerciseTemplate
        var counter: Int
        
        init(for template: ExerciseTemplate, counter: Int = 0) {
            self.template = template
            self.counter = counter
        }
        
        var id: UUID {
            template.id
        }
        
        var name: String {
            template.name
        }
    }
    
    struct SelectionRow: View {
        var item: SelectionItem
        var isAdded: Bool = false
        var onChange: (SelectionItem, Int) -> Void
        
        @State private var counter: Int
        
        init(item: SelectionItem, isAdded: Bool = false, onChange: @escaping (SelectionItem, Int) -> Void) {
            self.item = item
            self.isAdded = isAdded
            self.onChange = onChange
            
            self._counter = State<Int>(initialValue: item.counter)
        }

        var body: some View {
            HStack {
                Button() {
                    if isAdded {
                        if counter > 0 {
                            counter -= 1
                        }
                    } else {
                        counter += 1
                    }
                } label: {
                    Image(systemName: isAdded ? "minus.circle" : "plus.circle")
                        .foregroundColor(.customAccentColor)
                }
                .onChange(of: counter) { newCounter in
                    onChange(item, newCounter)
                }
                
                Text("\(counter)")
                    .font(.callout)
                    .foregroundColor(counter > 0 ? .creamy : .customAccentColor)
                    .frame(minWidth: 25)
                    .background(counter > 0 ? .customAccentColor : Color(UIColor.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.customAccentColor, lineWidth: 1)
                    )
                
                ExerciseShortView(for: item.template)
            }
        }
    }
}

struct ExerciseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSelectionView() { _ in }
    }
}
