//
//  ContentView.swift
//  WishLinks
//
//  Created by Mark Anjoul on 9/4/25.
//

import SwiftUI

struct AddItemView: View {

    var body: some View {
        NavigationStack{
            ZStack{
                //Background Gradient
                LinearGradient(colors: [Color(.systemBackground), Color(.secondarySystemBackground)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack{
                    //View Title
                    Text("Add Item to Your Wish Link")
                        .font(.system(size: 20, weight: .semibold))
                        .padding()
                }
            }
            
        }
    }
}

#Preview {
    AddItemView()
}
