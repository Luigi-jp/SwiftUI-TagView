//
//  TagViewWithAlignmentGuide.swift
//  TagListView-Sample
//
//  Created by Luigi Sato on 2023/08/05.
//

import SwiftUI

struct TagViewWithAlignmentGuide: View {

    let tags: [Tag] = [
        .init(title: "Swift"),
        .init(title: "SwiftUI"),
        .init(title: "UIKit"),
        .init(title: "Xcode"),
        .init(title: "Apple"),
        .init(title: "iOS"),
        .init(title: "iPad"),
    ]

    var body: some View {
        content()
    }

    private func content() -> some View {
        TagListView(items: tags, horizontalSpacing: 4, verticalSpacing: 4) { item in
            tagItemView(for: item)
        }
        .frame(height: 500)
    }

    private func tagItemView(for tag: Tag) -> some View {
        Button {
            // TODO: Button Action
        } label: {
            Text(tag.title)
                .foregroundColor(.primary)
                .padding()
                .lineLimit(1)
                .background(Color.secondary)
                .frame(height: 36)
                .cornerRadius(18)
                .overlay(
                    Capsule()
                        .stroke(Color.secondary, lineWidth: 1)
                )
        }
    }
}

struct TagViewWithAlignmentGuide_Previews: PreviewProvider {
    static var previews: some View {
        TagViewWithAlignmentGuide()
    }
}
