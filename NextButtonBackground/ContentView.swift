//
//  ContentView.swift
//  NextButtonBackground
//
//  Created by Maxim Keegan on 09.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var performAnimation: Bool = false

    var body: some View {
        Button {
            if !performAnimation {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
        } label: {
            GeometryReader { proxy in
                let width = proxy.size.width / 2
                let systemName = "play.fill"
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? width : .zero)
                        .opacity(performAnimation ? 1 : .zero)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .buttonStyle(ButtonBackground())
        .frame(maxWidth: 62)
    }
}

struct ButtonBackground: ButtonStyle {
    @State private var isPressed: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
            .padding()
            .background(Color(.gray.withAlphaComponent(isPressed ? 0.6 : 0)))
            .foregroundStyle(.blue)
            .clipShape(Circle())
            .scaleEffect(isPressed ? 0.86 : 1)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                if (newValue) {
                    withAnimation(.easeInOut(duration: 0.22)) {
                        isPressed = true
                    } completion: {
                        isPressed = false
                    }
                }
            }
    }
}

#Preview {
    ContentView()
}
