//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Freak on 17.03.2026.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.rect(cornerRadius: 10))
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

struct ContentView: View {
    @State private var useRedBg = true
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")

    var spells: some View {
        Group {
            Text("Lumos")
            Text("Obliviate")
        }
    }

    var blurryText: some View {
        VStack {
            Text("Gryffindor")
                .font(.largeTitle)
                .blur(radius: 0)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
            motto1
            motto2
        }
        .font(.title)
        .blur(radius: 5)
    }
    
    var welcomeTitles : some View{
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")

            spells
        }
        .padding()
        .prominent()
    }
    
    var colorChangingButton: some View {
        Button("Hello, world!") {
            print(type(of: self.body))
            useRedBg.toggle()
        }
        .frame(width: 200, height: 200)
        .background(useRedBg ? .red : .green)
    }

    var body: some View {
        ScrollView {
            blurryText
            welcomeTitles
            colorChangingButton
            

            VStack(spacing: 10) {
                CapsuleText(text: "First")
                CapsuleText(text: "Second")
            }

            Text("Hello, world!")
                .padding()
                .background(.red)
                .padding()
                .background(.blue)
                .padding()
                .background(.green)
                .padding()
                .background(.yellow)
                .modifier(Title())  // CUSTOM MODIFIER
                .titleStyle()  // CUSTOM MODIFIER

            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift")
        }
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }

    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }

    func prominent() -> some View {
        modifier(ProminentTitle())
    }
}

#Preview {
    ContentView()
}
