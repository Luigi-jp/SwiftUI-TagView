//
//  TagViewWithAlignmentGuide.swift
//  TagListView-Sample
//
//  Created by Luigi Sato on 2023/08/05.
//

import SwiftUI

struct TagViewWithAlignmentGuide: View {

    let tags: [Tag] = [
        .init(title: "長いタグ長いタグ長いタグ長いタグ長いタグ長いタグ"),
        .init(title: "バトル"),
        .init(title: "恋愛・ラブコメ"),
        .init(title: "ファンタジー"),
        .init(title: "日常"),
        .init(title: "青春・学園"),
        .init(title: "オリジナル"),
    ]

    var body: some View {
        content()
    }

    private func content() -> some View {
        TagListView(
            items: tags,
            horizontalSpacing: 4,
            verticalSpacing: 4) { item in
                tagItemView(for: item)
            }
    }

    private func tagItemView(for tag: Tag) -> some View {
        Button {
            print("$$$ Tapped tag id: \(tag.id)")
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
