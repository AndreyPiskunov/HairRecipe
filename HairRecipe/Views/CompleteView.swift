//
//  CompleteView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 26.04.2023.
//

import SwiftUI

struct CompleteSaveView: View {
    var body: some View {
        Text("Client saved")
            .font(.headline)
            .padding()
            .background(.thinMaterial,
                        in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CompleteDeleteView: View {
    var body: some View {
        Text("Client deleted")
            .font(.headline)
            .padding()
            .background(.thinMaterial,
                        in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

//struct CompleteView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompleteView()
//    }
//}
