//
//  CompleteView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 26.04.2023.
//

import SwiftUI

struct CompleteView: View {
    var body: some View {
        VStack {
            Image(systemName: "checkmark")
                .font(.system(.largeTitle, design: .rounded).bold())
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        }
    }
}

struct CompleteView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteView()
    }
}
