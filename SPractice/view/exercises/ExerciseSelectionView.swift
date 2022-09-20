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
        NavigationStack {
            List {
                Section {
                    ForEach(viewModel.sortedElements) { item in
                        SelectionRow(item: item, isAdded: viewModel.itemsGroup == .prepared) {
                            viewModel.onChange()
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
                                .font(.footnote)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
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
                        onAdd(viewModel.preparedExercises)
                        dismiss()
                    }
                    .disabled(viewModel.isAddDisabled)
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

    class SelectionItem: Identifiable, Named, Created {
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

        var creationDate: Date {
            template.creationDate
        }
    }

    struct SelectionRow: View {
        var item: SelectionItem
        var isAdded: Bool = false
        var onChange: () -> Void

        var body: some View {
            HStack {
                Button {
                    if isAdded {
                        if item.counter > 0 {
                            item.counter -= 1
                        }
                    } else {
                        item.counter += 1
                    }
                    onChange()
                } label: {
                    Image(systemName: isAdded ? "minus.circle" : "plus.circle")
                        .foregroundColor(.customAccentColor)
                }

                Text("\(item.counter)")
                    .font(.callout)
                    .foregroundColor(item.counter > 0 ? .textColor : .customAccentColor)
                    .frame(minWidth: 25)
                    .if(item.counter > 0) {
                        $0.background(.customAccentColor)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                    .overlay(
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(.customAccentColor, lineWidth: 1.3)
                    )

                ExerciseShortView(for: item.template) {
                    ExerciseIcon(for: item.template.exerciseType)
                }
            }
            .rowLeadingAligned()
        }
    }
}

struct ExerciseSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseSelectionView { _ in }
    }
}
