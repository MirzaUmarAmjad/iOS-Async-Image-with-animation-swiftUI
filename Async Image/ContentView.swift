//
//  ContentView.swift
//  Async Image
//
//  Created by Umar Amjad on 17/02/2023.
//

import SwiftUI

extension Image{
    func imageModifier() -> some View{
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier() -> some View{
        self
            .imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
            .opacity(0.5)
    }
}

struct ContentView: View {
    private let imageURL: String = "https://credo.academy/credo-academy@3x.png"
    
    var body: some View {
        
        AsyncImage(url: URL(string: imageURL),transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
            
            switch phase{
            case .success(let image):
                image.imageModifier()
                    .transition(.push(from: .bottom))
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifier()
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifier()
            @unknown default:
                ProgressView()
            }
            
        }
        .padding(40)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
