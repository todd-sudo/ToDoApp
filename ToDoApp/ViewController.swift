import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    // Получение контекста
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var tableView: UITableView = {
            let table = UITableView()
            table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            return table
    }()

    var models = [ToDoListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ToDo List"
        view.addSubview(tableView)
      
        self.crudData().getAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }

        
    @objc private func didTapAdd() {
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            
            self?.crudData().createItem(name: text)
        }))
        
        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "\(model.name!) - \(model.createdAt!)"
        cell.textLabel?.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = models[indexPath.row]
        
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        sheet.addAction(UIAlertAction(title: "Cansel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { [weak self] _ in
            
            let alert = UIAlertController(title: "Edit Item", message: "Edit your item", preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                
                self?.crudData().updateItem(item: item, newName: newName)
            }))
            
            self?.present(alert, animated: true)
            
        }))
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.crudData().deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
    }
    
    func crudData() -> Crud {
        let crud = Crud(models: self.models, tableView: self.tableView)
        return crud
    }
}
