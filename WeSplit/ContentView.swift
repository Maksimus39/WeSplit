//
//  ContentView.swift
//  WeSplit
//
//  Created by Максим Минаков on 21.09.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tapCount = 0
    @State private var name = ""
    
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Hello, world!: \(name)")
                    Picker("Select your student", selection: $selectedStudent){
                        ForEach(students, id: \.self){
                            Text($0)
                        }
                    }
                    Button("Tap Count: \(tapCount)") {
                        self.tapCount += 1
                    }
                }
                .navigationTitle("Моё первое приложение")
                .navigationBarTitleDisplayMode(.large)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        

    }
}

#Preview {
    ContentView()
}
