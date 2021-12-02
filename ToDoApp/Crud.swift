//import Foundation
//import UIKit
//
//
//class CrudToDo {
//    // MARK: CRUD data
//
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//
//    var models: [ToDoListItem]
//    var tableView: UITableView
//
//    init(models: [ToDoListItem], tableView: UITableView){
//        self.models = models
//        self.tableView = tableView
//    }
//
//    // Получение списка объектов
//    func getAllItems() {
//        do {
//            models = try context.fetch(ToDoListItem.fetchRequest())
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//        catch {
//            print("error")
//        }
//    }
//
//    // Создание объекта
//    func createItem(name: String) {
//        let newItem = ToDoListItem(context: context)
//        newItem.name = name
//        newItem.createdAt = Date()
//
//        do {
//            try context.save()
//            getAllItems()
//        }
//        catch {
//
//        }
//    }
//
//    // Удаление объекта
//    func deleteItem(item: ToDoListItem) {
//        context.delete(item)
//
//        do {
//            try context.save()
//            getAllItems()
//        }
//        catch {
//
//        }
//    }
//
//    // Обновление объекта
//    func updateItem(item: ToDoListItem, newName: String) {
//        item.name = newName
//
//        do {
//            try context.save()
//            getAllItems()
//        }
//        catch {
//
//        }
//    }
//}
