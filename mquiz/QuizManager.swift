//
//  QuizManager.swift
//  mquiz
//
//  Created by Daniel Castillo Bermudez on 28/3/24.
//

import Foundation
import Supabase


class QuizManager: ObservableObject {

    @Published var questions = [Question]()

//    @Published var mockQuiestions = [
//        Question(title: "First question", answer: "A", options: ["A","B","C","D"]),
//        Question(title: "Second question", answer: "A", options: ["A","B","C","D"]),
//        Question(title: "Thrid question", answer: "A", options: ["A","B","C","D"]),
//        Question(title: "Fourth question", answer: "A", options: ["A","B","C","D"])
//    ]
    let client = SupabaseClient(supabaseURL: URL(string: "https://hitzceseefvspljdmwfz.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhpdHpjZXNlZWZ2c3BsamRtd2Z6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTEwNTQxMDcsImV4cCI6MjAyNjYzMDEwN30.EE0DQq0GF6FaRAqq9YxgKPVvyRiAw4g1DGY54WlN6ak")
    
    init() {
            Task {
                do {
                print("Before query")
                let response = try await client.database.from("quiz").select().execute()
                    let data = response.data
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let questions = try decoder.decode([Question].self, from: data)
                    await MainActor.run{
                        self.questions = questions
                    }
                print(questions)
            } catch {
                print("Error fetching question")
            }
        }
    }
    
    func canSubmitQuiz() -> Bool {
            return questions.filter({$0.selection == nil}).isEmpty
    }
    func gradeQuiz() -> String {
        var correct: CGFloat = 0
        for question in questions {
            if question.answer == question.selection {
                correct += 1
            }
        }
        return "\((correct/CGFloat(questions.count)) * 100) %"
    }
}

