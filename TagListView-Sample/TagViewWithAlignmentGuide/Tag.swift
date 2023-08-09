//
//  Tag.swift
//  TagListView-Sample
//
//  Created by Luigi Sato on 2023/08/09.
//

import Foundation

struct Tag: Hashable {
    let id: String = UUID().uuidString
    let title: String

    init(title: String) {
        self.title = title
    }
}
