//
//  ContentView.swift
//  mquiz
//
//  Created by Daniel Castillo Bermudez on 22/3/24.
//

import SwiftUI

class QuizManager: ObservableObject {
    @Published var mockQuiestions = [
        Question(title: "First question", answer: "A", options: ["A","B","C","D"]),
        Question(title: "Second question", answer: "A", options: ["A","B","C","D"]),
        Question(title: "Thrid question", answer: "A", options: ["A","B","C","D"]),
        Question(title: "Fourth question", answer: "A", options: ["A","B","C","D"])
    ]
    func canSubmitQuiz() -> Bool {
            return mockQuiestions.filter({$0.selection == nil}).isEmpty
    }
    func gradeQuiz() -> String {
        var correct: CGFloat = 0
        for question in mockQuiestions {
            if question.answer == question.selection {
                correct += 1
            }
        }
        return "\((correct/CGFloat(mockQuiestions.count)) * 100) %"
    }
}

struct ContentView: View {
    @StateObject var manager = QuizManager()
    var body: some View {
        TabView {
            ForEach(manager.mockQuiestions.indices, id:\.self) {
                index in
                VStack {
                    Spacer()
                    QuestionView(question: $manager.mockQuiestions[index])
                    Spacer()
                    if let lastQuestion = manager.mockQuiestions.last, lastQuestion.id == manager.mockQuiestions[index].id {
                        Button {
                            print(manager.canSubmitQuiz())
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
    }
}

#Preview {
    ContentView()
}
