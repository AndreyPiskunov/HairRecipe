//
//  ClientRowView.swift
//  HairRecipe
//
//  Created by Andrey Piskunov on 03.03.2023.
//

import SwiftUI

struct ClientRowView: View {
    
    @ObservedObject var client: Client
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(client.name)
                .font(.system(size: 25, weight: .medium))
            Text(client.procedure)
                .font(.system(size: 14))
                .foregroundColor(ColorsApp.customGreen)
            Text(client.date, style: .date)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ClientRowView_Previews: PreviewProvider {
    static var previews: some View {
        ClientRowView(client: .preview())
    }
}
