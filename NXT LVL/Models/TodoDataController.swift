//
//  TodoDataController.swift
//  NXT LVL
//
//  Created by Aleck Holly on 2022-12-11.
//

import Foundation
import CoreData

class TodoDataController: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    @Published var savedText: [TodoList] = []
    
    init() {
        container.loadPersistentStores{ description, error in
            if let error = error {
                print(error)
            }
        }
        fetchTodo()
    }
    
    func fetchTodo() {
        let request = NSFetchRequest<TodoList>(entityName: "TodoList")
        
        do {
            savedText = try container.viewContext.fetch(request)
        } catch let error {
            print(error)
        }
    }
    
    func addTodo(text: String) {
        let newText = TodoList(context: container.viewContext)
        newText.todoText = text
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchTodo()
        } catch let error {
            print(error)
        }
    }
    
    func deleteTodo(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let todo = savedText[index]
        container.viewContext.delete(todo)
        saveData()
    }
}
