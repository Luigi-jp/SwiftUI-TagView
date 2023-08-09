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
            ForEach(Array(items), id: \.self) { item in
                content(item)
                    .padding(.horizontal, horizontalSpacing)
                    .padding(.vertical, verticalSpacing)
                    .alignmentGuide(.leading) { d in
                        if abs(width - d.width) > geometory.size.width {
                            // ビューの幅を超えた場合は改行
                            width = 0
                            height -= lastHeight
                        }

                        lastHeight = d.height
                        let result = width
                        width -= d.width
                        return result
                    }
                    .alignmentGuide(.top) { _ in
                        return height
                    }
            }
        }


    }
}
