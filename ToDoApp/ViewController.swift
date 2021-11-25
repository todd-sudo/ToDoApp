import UIKit


class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Получение списка объектов
    func getAllItems() {
        do {
            let items = try context.fetch(ToDoListItem.fetchRequest())
            
        }
        catch {
            // error
        }
    }
    
    // Создание объекта
    func createItem(name: String) {
        let newItem = ToDoListItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    // Удаление объекта
    func deleteItem(item: ToDoListItem) {
        context.delete(item)
        
        do {
            try context.save()
        }
        catch {
            
        }
    }
    
    // Обновление объекта
    func updateItem(item: ToDoListItem, newName: String) {
        item.name = newName
        
        do {
            try context.save()
        }
        catch {
            
        }
    }
}

