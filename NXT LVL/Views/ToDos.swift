//
//  ToDos.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-05.
//

import SwiftUI
import PartialSheet

struct ToDos: View {
    
    @State private var showingCredits = false
    @State private var todoText: [TodoList] = [TodoList]()
    @State var textFieldText: String = ""
    @StateObject var todoDataController = TodoDataController()
    @State private var longer: Bool = false
    
    init() {
      if #unavailable(iOS 16.0) {
        UITableView.appearance().backgroundColor = .clear
      }
    }
    
    var body: some View {
        ZStack {
                NavigationView() {
                    List {
                        ForEach(todoDataController.savedText) { text in
                            HStack {
                                Text(text.todoText ?? "")
                                    .multilineTextAlignment(.trailing)
                                    .padding(.all, 1)
                                Spacer()
                            }
                        }
                        .onDelete(perform: todoDataController.deleteTodo)
                        Text("Swipe left to delete a note..")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color("lightGray"))
                    }
                    .clearListBackground()
                    .background(Image("Home").resizable(capInsets: EdgeInsets()).aspectRatio(contentMode: .fill).opacity(0.95).edgesIgnoringSafeArea(.all))
                    .navigationTitle("To Do's")
                }
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showingCredits.toggle()
                    }
                           , label: {
                        Image(systemName: "plus")
                            .font(.system(.largeTitle))
                            .clipShape(Circle())
                            .frame(width: 60.0, height: 60.0)
                            .foregroundColor(Color("AccentColor"))
                            .padding(.all, 7)
                    })
                    .partialSheet(isPresented: $showingCredits) {
                        VStack{
                            Spacer()
                            TextField("Add A Note: ", text: $textFieldText)
                                .onSubmit{
                                    addToDo()
                                }
                                .submitLabel(.done)
                                .font(.headline)
                                .padding(.horizontal)
                                .frame(height: 55)
                                .background(Color("lightGray"))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            Spacer()
                            Button("Save Note") {
                                addToDo()
                            }
                            .padding(.all, 10.0)
                            .foregroundColor(Color("ReverseAccColor"))
                            .background(Color("AccentColor"))
                            .cornerRadius(10)
                            Spacer()
                        }
                        .frame(height: 350)
                    }
                    .background(Color("ReverseAccColor"))
                    .cornerRadius(38.5)
                    .padding()
                    .shadow(color: .gray, radius: 5, x: 3, y: 3)
                }
            }
            .padding(.bottom, 15)
        }
    }
    
    func addToDo() {
        guard !textFieldText.isEmpty else { return }
        todoDataController.addTodo(text: textFieldText)
        textFieldText = ""
        showingCredits.toggle()
    }
}

struct ToDos_Previews: PreviewProvider {
    static var previews: some View {
        ToDos()
    }
}
