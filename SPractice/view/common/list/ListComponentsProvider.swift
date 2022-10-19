//
//  ListComponentsProvider.swift
//  SPractice
//
//  Created by Yuliya Charniak on 19.10.22.
//

import Foundation
import SwiftUI

protocol ListComponentsProvider {

    associatedtype Item: Hashable, ExampleItem

    associatedtype ShortView: View
    associatedtype DetailsView: View, UpdateProcessor, DeleteProcessor where DetailsView.Item == Self.Item
    associatedtype AddItemView: View, AddProcessor where AddItemView.Item == Self.Item

    var title: String {get}

    var addItemView: AddItemView {get}
    func getShortView(item: Item, isAccented: Bool) -> ShortView
    func getDetailsView(item: Item) -> DetailsView
}

protocol AddProcessor {
    associatedtype Item
    var onAdd: ((Item) -> Void)? {get set}
}

protocol UpdateProcessor {
    associatedtype Item
    var onUpdate: ((Item) -> Void)? {get set}
}

protocol DeleteProcessor {
    associatedtype Item
    var onDelete: ((Item) -> Void)? {get set}
}
