//
//  ClientRowView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 03.03.2023.
//

import SwiftUI

struct ClientRowView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Name")
                .font(.system(size: 26, weight: .bold))
            Text("Procedure")
            Text("Date")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ClientRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClientRowView()
    }
}
