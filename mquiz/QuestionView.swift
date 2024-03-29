//
//  QuestionView.swift
//  mquiz
//
//  Created by Daniel Castillo Bermudez on 22/3/24.
//

import SwiftUI

struct Question: Identifiable, Decodable {
    let id: Int
    let createdAt: String
    let title: String
    let answer: String
    let options: [String]
    var selection: String?
}

struct QuestionView: View {
    @Binding var question: Question
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(question.title)
            ForEach(question.options, id:\.self) {option in
                HStack {
                    Button {
                        question.selection = option
                        print(option)
                    } label: {
                        if question.selection == option {
                            Circle()
                                
                                .shadow(radius: 3)
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color("AppColor"))
                        } else {
                            Circle()
                                .stroke()
                                .shadow(radius: 3)
                                .frame(width: 24, height: 24)
                        }
                      
                }
                    Text(option)
                }
            }
        }
        .foregroundColor(Color(uiColor: .secondaryLabel))
        .padding(.horizontal, 40)
        .frame(width: 700, height: 1000, alignment: .leading)
        .background(Color(uiColor: .systemGray6))
        .cornerRadius(20)
        .shadow(color: Color(uiColor: .label).opacity(0.2), radius: 10)
    }
}

#Preview {
    QuestionView(question:.constant(Question(id: 1, createdAt: "created", title: "In which year was the iPhone introduced?", answer: "2007", options: ["2006", "2007", "2008", "2009", "2010"])) )
}
