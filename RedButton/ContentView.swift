//
//  ContentView.swift
//  RedButton
//
//  Created by Mariana Yamamoto on 8/18/21.
//

import AVFoundation
import SwiftUI

struct MyNewPrimitiveButtonStyle: PrimitiveButtonStyle {
    var color: Color

    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration, color: color)
    }

    struct MyButton: View {
        @State private var pressed = false

        let configuration: PrimitiveButtonStyle.Configuration
        let color: Color

        var body: some View {

            return configuration.label
                .foregroundColor(.white)
                .padding(15)
                .background(Circle().fill(color))
                .compositingGroup()
                .shadow(color: .black, radius: 3)
                .opacity(self.pressed ? 0.5 : 1.0)
                .scaleEffect(self.pressed ? 0.8 : 1.0)
                .onLongPressGesture(minimumDuration: 2.5, maximumDistance: .infinity, pressing: { pressing in
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.pressed = pressing
                    }
                    if pressing {
                        AudioServicesPlaySystemSound( 1104)
                    }
                }, perform: { })
        }
    }
}
struct RedButton: View {
    var body: some View {
        Button(action: {
            print("MyNewPrimitiveButton triggered. Is it printed ?")
        }) {
            Circle()
                .fill(
                    Color.red
                )
                .frame(width: 50, height: 50)
        }
        .buttonStyle(MyNewPrimitiveButtonStyle(color: .red))
    }
}

struct ContentView: View {
    @State private var enabled = false

    var body: some View {
        HStack(spacing: 20) {
            ForEach(0 ..< 3) { _ in
                VStack(spacing: 20) {
                    ForEach(0 ..< 3) { _ in
                        RedButton()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
