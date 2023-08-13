//
//  TagListView.swift
//  TagListView-Sample
//
//  Created by Luigi Sato on 2023/08/09.
//

import SwiftUI

struct TagListView<Data: Collection, Content: View>: View where Data.Element: Hashable {

    /// アイテムのリスト
    let items: Data
    /// アイテム同士のスペース（横）
    let horizontalSpacing: CGFloat
    /// アイテム同士のスペース（縦）
    let verticalSpacing: CGFloat
    /// アイテムのView（ex: タグ）
    let content: (Data.Element) -> Content

    var body: some View {
        GeometryReader { geometory in
            tagListView(in: geometory)
        }
    }

    private func tagListView(in geometory: GeometryProxy) -> some View {
        var width: CGFloat = .zero
        var height: CGFloat = .zero
        var lastHeight: CGFloat = .zero

        return ZStack(alignment: .topLeading) {
            ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                content(item)
                    .padding(.horizontal, horizontalSpacing)
                    .padding(.vertical, verticalSpacing)
                    .alignmentGuide(.leading) { d in
                        if abs(width - d.width) > geometory.size.width {
                            // 同じ行の1つ前までのタグの横幅と追加対象のタグの横幅の合計がViewの横幅を超えている場合は、widthをリセットして改行
                            width = 0
                            height -= lastHeight
                        }

                        lastHeight = d.height
                        let result = width

                        if index == items.count - 1 {
                            // Tagが最後の場合はwidthをリセットする
                            // ForEachが複数回呼ばれるためリセットしないと意図した表示にならない（複数回呼ばれる理由は分かってない。。。）
                            width = 0
                        } else {
                            // タグの幅をwidthに追加する
                            width -= d.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        let result = height

                        if index == items.count - 1 {
                            // Tagが最後の場合はheightをリセットする
                            // ForEachが複数回呼ばれるためリセットしないと意図した表示にならない（複数回呼ばれる理由は分かってない。。。）
                            height = 0
                        }
                        return result
                    }
            }
        }
    }
}
