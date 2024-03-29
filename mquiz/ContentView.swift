//
//  ContentView.swift
//  mquiz
//
//  Created by Daniel Castillo Bermudez on 22/3/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var manager = QuizManager()
    @State var showStart = false
    @State var showResults = false
    
    var body: some View {
        TabView {
            ForEach(manager.questions.indices, id:\.self) {
                index in
                VStack {
                    Spacer()
                    QuestionView(question: $manager.questions[index])
                    Spacer()
                    if let lastQuestion = manager.questions.last, lastQuestion.id == manager.questions[index].id {
                        Button {
                            print(manager.gradeQuiz())
                        } label: {
                            Text("submit")
                                .padding()
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(Color("AppColor"))
                                        .frame(width: 300))
                        }
                        .buttonStyle(.plain)
                        .disabled(!manager.canSubmitQuiz())
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .fullScreenCover(isPresented: $showStart) {
            
        }
        .fullScreenCover(isPresented: $showResults) {
            
        }
    }
}

#Preview {
    ContentView()
}
