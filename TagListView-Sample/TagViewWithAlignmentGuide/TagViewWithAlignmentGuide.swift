//
//  TagViewWithAlignmentGuide.swift
//  TagListView-Sample
//
//  Created by Luigi Sato on 2023/08/05.
//

import SwiftUI

// Model
struct Tag: Equatable {
    let id: String = UUID().uuidString
    let title: String

    init(title: String) {
        self.title = title
    }
}

struct TagViewWithAlignmentGuide: View {

    let tags: [Tag] = [
        .init(title: "バトルバトルバトルバトルバトルバトルバトルバトル"),
        .init(title: "恋愛"),
        .init(title: "ファンタジー"),
        .init(title: "RPG"),
        .init(title: "日常"),
    ]

    var body: some View {
        VStack(alignment: .leading) {
            GeometryReader { geometry in
                content(in: geometry)
            }
        }
    }

    private func content(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(tags.indices) { index in
                tagItemView(for: tags[index])
                    .padding(.horizontal, 4)
                    .alignmentGuide(.leading) { d in
                        if abs(width - d.width) > geometry.size.width {
                            // 横並びのタグが親ビューの幅を超えたらwidthをリセット & タグの高さ分heightを下にずらす
                            width = 0
                            height -= d.height
                        }
                        let result = width

                        if let lastTag = tags.last,
                           tags[index] == lastTag {
                            // 最後のタグの場合は、widthをリセット
                            width = 0
                        } else {
                            // 追加するタグの横幅分widthを追加
                            width -= d.width
                        }

                        // resultの分（1つ前までのタグの横幅分）だけタグを後ろにずらす
                        return result
                    }
                    .alignmentGuide(.top) { d in
                        let result = height

                        if let lastTag = tags.last,
                           tags[index] == lastTag {
                            height = 0
                        }

                        return result
                    }
            }
        }
    }

    private func tagItemView(for tag: Tag) -> some View {
        Button {
            // todo
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
