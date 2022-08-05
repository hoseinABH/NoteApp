//
//  CreditView.swift
//  Notes WatchKit Extension
//
//  Created by hosein on 5/14/1401 AP.
//

import SwiftUI

struct CreditView: View {
    @State private var randomNumber : Int = Int.random(in: 1..<4)
    
    private var randomImage :String {
        return "developer-no\(randomNumber)"
    }
    var body: some View {
        VStack(spacing:3) {
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            HeaderView(title: "Credits")
             
            Text("Hosein Abolhasani")
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}

struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}
