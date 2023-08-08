//
//  TagKitView.swift
//  TagListView-Sample
//
//  Created by Luigi Sato on 2023/08/05.
//

import TagKit
import SwiftUI

struct TagKitView: View {

    let marvels = ["アイアンマンアイアンマンアイアンマンアイアンマン"]

    @State var fontSize: CGFloat = 15
       var body: some View {
           NavigationView {
               ScrollView(.vertical) {
                   tag
               }
               .navigationTitle("マーベル映画")
               .navigationBarTitleDisplayMode(.inline)
               .toolbar {
                   Button {
                       fontSize -= 1
                   } label: {
                       Image(systemName: "minus")
                   }
                   Button {
                       fontSize += 1
                   } label: {
                       Image(systemName: "plus")
                   }
               }
           }
       }

       var tag: some View {
           TagList(tags: marvels) { marvel in
               Text(marvel)
                   .foregroundColor(.blue)
                   .font(.system(size: fontSize, weight: .medium))
                   .padding(.init(top: 5, leading: 8, bottom: 5, trailing: 8))
                   .overlay(.blue, in: RoundedRectangle(cornerRadius: 10).stroke(style: .init(lineWidth: 1)))
           }
       }
}

struct TagKitView_Previews: PreviewProvider {
    static var previews: some View {
        TagKitView()
    }
}
