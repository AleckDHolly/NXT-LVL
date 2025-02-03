//
//  ToDos.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-05.
//

import SwiftUI

struct Notes: View {
    
    @State private var showingSheet = false
//    @State private var todoText: [TodoList] = [TodoList]()
    @State var textFieldText: String = ""
    @State private var selectedTodo: TodoList?
    @StateObject var todoDataController = TodoDataController()
    
    var body: some View {
        ZStack {
            NavigationView() {
                GeometryReader{ geo in
                    List {
                        ForEach(todoDataController.savedText) { text in
                            HStack {
                                Text(text.todoText ?? "")
                                    .multilineTextAlignment(.trailing)
                                    .padding(.all, 1)
                                Spacer()
                            }
                            .onLongPressGesture {
                                selectedTodo = text
                                textFieldText = text.todoText ?? ""
                                showingSheet = true
                            }
                        }
                        .onDelete(perform: todoDataController.deleteTodo)
                        Text("Swipe left to delete a note..")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(Color("lightGray"))
                    }
                    .clearListBackground()
                    .background(Image(.mindset).resizable(capInsets: EdgeInsets()).aspectRatio(contentMode: .fill).opacity(0.95).ignoresSafeArea().offset(x: -geo.size.width/4))
                    .navigationTitle("Notes")
                }
            }
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        selectedTodo = nil
                        textFieldText = ""
                        showingSheet = true
                    }, label: {
                        Image(systemName: "plus")
                            .font(.system(.largeTitle))
                            .clipShape(Circle())
                            .frame(width: 60.0, height: 60.0)
                            .foregroundColor(Color("AccentColor"))
                            .padding(.all, 7)
                    })
                    .sheet(isPresented: $showingSheet) {
                        VStack{
                            Spacer()
                            TextField("Add A Note: ", text: $textFieldText)
                                .onSubmit{
                                    saveNote()
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
                                saveNote()
                            }
                            .padding(.all, 10.0)
                            .foregroundColor(Color("ReverseAccColor"))
                            .background(Color("AccentColor"))
                            .cornerRadius(10)
                            Spacer()
                        }
                        .presentationDetents([.medium])
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
    
    func saveNote() {
        guard !textFieldText.isEmpty else { return }
        if let todo = selectedTodo {
            todoDataController.updateTodo(todo, with: textFieldText)
        } else {
            todoDataController.addTodo(text: textFieldText)
        }
        textFieldText = ""
        showingSheet = false
    }
}

struct Notes_Previews: PreviewProvider {
    static var previews: some View {
        Notes()
    }
}
