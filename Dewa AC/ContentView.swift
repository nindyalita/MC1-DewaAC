//
//  ContentView.swift
//  Dewa AC
//
//  Created by Nindya Alita Rosalia on 01/04/23.
//

import SwiftUI

struct ContentView: View {
    let dispatchQueue = DispatchQueue(label: "update", qos: .background)
    
    @StateObject var questions : Questions
    
    var body: some View{
        HStack{
            ZStack{
                Rectangle()
                    .fill(Color("Purple rectangle"))
                    .frame(width: 350, height: 350)
                    .cornerRadius(20)
                    .padding(.top, 30.0)
                VStack{
                    Text("Addition")
                        .foregroundColor(.white)
                        .padding(.vertical, 10.0)
                        .font(.custom("SFCompactRounded-Heavy", size: 36))
                        .fontWeight(.bold)
                    
                    //DROP AREAA!!!
                    DropArea()
                    
                    .padding(.horizontal, 32.0)
                    .padding(.vertical, -7.0)
                }
            }
            
            VStack{
                
                Spacer()
                Button("Replay"){
                    questions.randomQuestions()
                }
                
                Spacer()
                Text("ayo geser jawaban\n di bawah\n ke kolom pertanyaan")
                    .font(.custom("SFMono-Semibold", size: 12))
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.white)
                    .padding(.trailing, -100.0)
                    
                    
                Spacer()
                //DRAG AREA!!
                DragArea()
                
                .padding(.horizontal, 11.0)
                .padding(.vertical, -7.0)
            }
        }

        .background(Image("bg")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
        )
    }
    
    @ViewBuilder
    func DragArea() -> some View{
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 5){
            
            ForEach(questions.questions.shuffled(), id:\.id){
                item in
                CardAnswerView(question: item)
                    .onDrag{
                        return .init(contentsOf: URL(string: String(item.id)))!
                    }
                
            }
        }
    }
    
    @ViewBuilder
    func DropArea() -> some View{
        LazyVGrid(columns:[GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing:-25){
            ForEach(questions.questions, id:\.id){
                item in
                VStack {
                    CardQuestionView (question : item)
                        .onDrop(of: [.url], isTargeted: .constant(false)){
                            providers in
                            
                            if let first = providers.first{
                                let _ = first.loadObject(ofClass: URL.self){
                                    value, error in
                                    
                                    guard let url = value else{return}
                                    
                                    if String(item.id) == "\(url)" {
                                        
                                        dispatchQueue.async{
                                          //Time consuming task here
                                            DispatchQueue.main.async{ item.isShowing = false }
                                        }
                                    }
                                }
                            }
                            
                            return false
                    }
                    
//                    if item.isShowing {
//                        Text("Render")
//                    }
                    
                }
                
                
                
            }
        }
    }
}


struct CardQuestionView : View{
    @StateObject var question: Question
    var body: some View{
        ZStack{
            Text(question.soal)
                .font(.custom("SFMono-Semibold", size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 100, height: 80)
        .padding([.top, .leading, .trailing], -10.0)
        .background(Color ("Purple question"))
        .clipped(antialiased: true)
        .border(Color("border question"), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        .opacity(question.isShowing ? 1: 0)
    }
}

struct CardAnswerView : View{
    @StateObject var question: Question
    var body: some View{
        ZStack{
            Text (String(question.jawaban)).font(.custom("SFCompactRounded-Semibold", size: 20))
                .fontWeight(.bold)
                .foregroundColor(.white )
                .padding()
        }
        .frame(width: 85, height: 45)
        .background(Color("Purple answer"))
        .border(Color("border answer"), width: 5)

        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .clipped(antialiased: true)
        .opacity(question.isShowing ? 1 : 0)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(questions: Questions())
    }
}
