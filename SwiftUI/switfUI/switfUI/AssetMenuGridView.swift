//
//  AssetMenuGridView.swift
//  switfUI
//
//  Created by dongyeongkang on 2023/01/12.
//

import SwiftUI

struct AssetMenuGridView: View {
    
    let data = Array(1...8).map({ "목록 \($0)"})
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(data, id: \.self) { i in
                ZStack {
                    Text(i)
                }
                .frame(width: 100, height: 100)
                .background(Color.white)
                
            }
        }
        .padding(.horizontal)
    }
}

struct AssetMenuGridView_Previews: PreviewProvider {
    static var previews: some View {
        AssetMenuGridView()
    }
}
