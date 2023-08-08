//
//  TagView.swift
//  TagListView-Sample
//
//  Created by Luigi Sato on 2023/08/06.
//

import SwiftUI

struct TagItem: Identifiable, Hashable {
    var id = UUID().uuidString
    var text: String
    var size: CGFloat = 0
}

struct TagView: View {

    @StateObject var viewModel = ViewModel()

    var body: some View {
        content()
            .onAppear {
                viewModel.getTags()
            }
    }

    private func content() -> some View {
        VStack(alignment: .leading) {
            ForEach(viewModel.rows, id: \.self) { row in
                HStack(spacing: 6) {
                    ForEach(row, id: \.id) { tag in
                        tagItemView(tag)
                    }
                }
            }
        }
        .padding(.horizontal, 5)
    }

    private func tagItemView(_ tag: TagItem) -> some View {
        Text(tag.text)
            .font(.system(size: 16))
            .lineLimit(1)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.gray)
            )
            .foregroundColor(.primary)
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView()
    }
}

class ViewModel: ObservableObject {

    @Published var rows: [[TagItem]] = []
    @Published var tags: [TagItem] = [
        .init(text: "長いタグ長いタグ長いタグ長いタグ長いタグ長いタグ"),
        .init(text: "バトル"),
        .init(text: "恋愛・ラブコメ"),
        .init(text: "ファンタジー"),
        .init(text: "日常"),
        .init(text: "青春・学園"),
        .init(text: "オリジナル"),
    ]

    @Published var tagText = ""

    func getTags() {
        var rows: [[TagItem]] = []
        var currentRow: [TagItem] = []

        var totalWidth: CGFloat = 0

        let screenWidth = UIScreen.screenWidth - 10
        // tagの左右のpadding
        let padding: CGFloat = 14
        // tag同士のスペース
        let spacing: CGFloat = 6

        if !tags.isEmpty {
            for index in 0..<tags.count {
                // tagのテキストサイズを取得
                self.tags[index].size = tags[index].text.getSize()
            }

            tags.forEach { tag in
                totalWidth += (tag.size + padding * 2 + spacing * 2)

                if totalWidth > screenWidth {
                    // タグの合計幅がスクリーン幅を超えた場合は改行
                    totalWidth = (tag.size + padding * 2 + spacing * 2)
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                } else {
                    // タグの合計幅がスクリーン幅を越えるまでは現在の行に追加
                    currentRow.append(tag)
                }
            }

            // 最後に処理していた行をrowsに追加
            if !currentRow.isEmpty {
                rows.append(currentRow)
                currentRow.removeAll()
            }

            self.rows = rows
        } else {
            self.rows = []
        }
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.width
}

extension String {
    func getSize() -> CGFloat {
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        let size = (self as NSString).size(withAttributes: attributes)
        return size.width
    }
}
