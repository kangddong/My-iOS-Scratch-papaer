//
//  SFSymbol7.swift
//  HelloXcode26
//
//  Created by 강동영 on 6/11/25.
//

import SwiftUI

struct SFSymbol7: View {
    @State private var isChecked: Bool = false
    var body: some View {
        VStack {
            Image(systemName: "stop.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
            
            Image(systemName: "checkmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                
        }
        .symbolEffect(.drawOff, options: .default, isActive: true)
//        .symbolEffect(.bounce, value: isChecked)
        .onAppear {
            isChecked = true
        }
        .onChange(of: isChecked) { oldValue, newValue in
            isChecked.toggle()
        }
        
    }
}

#Preview {
    SFSymbol7()
}
