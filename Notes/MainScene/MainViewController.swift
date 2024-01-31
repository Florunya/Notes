//
//  MainViewController.swift
//  Notes
//
//  Created by Флора Гарифуллина on 29.01.2024.
//

import Foundation
import UIKit

class MainViewController: UIViewController{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let contentView = MainView()
    private var notes = [Notes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Заметки"
        configureTableView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        isListEmpty()
    }
    
    
    override func loadView() {
        view = contentView
    }
    
    func configureTableView(){
        getAllItems()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cellId")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapAdd))

    }
    
    func getAllItems(){
        do{
            notes = try context.fetch(Notes.fetchRequest())
            DispatchQueue.main.async {
                self.isListEmpty()
                self.contentView.tableView.reloadData()
            }
        }
        catch{
            print("Something wrong with getting all items")
        }
    }
    
    func createItem(title: String){
        
        let newItem = Notes(context: context)
        newItem.tittle = title
        
        do{
            try context.save()
            getAllItems()
        }
        catch{
            print("Create new item is failed")
        }
    }
    
    func deleteItem(item: Notes){
        
        context.delete(item)
        do{
            try context.save()
            getAllItems()
        }
        catch{
            print("Delete is failed")
        }
    }
    
    func updateItem(item: Notes, newName: String){
        item.tittle = newName
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
        }
    }
    
    func isListEmpty(){
        if self.notes.count == 0 {
            contentView.emptyLabel.isHidden = false
        }else {
            contentView.emptyLabel.isHidden = true
        }
//        loadData()
    }
    
    @objc private func didTapAdd(){
        //MARK: ADD view
        let alert = UIAlertController(title: "Новая заметка",
                                      message: "Введите свою заметку",
                                      preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Добавить",
                                      style: .cancel,
                                      handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItem(title: text)
        }))
        present(alert, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notes.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
//        cell.backgroundColor = .background
        cell.textLabel?.text = model.tittle
        cell.layer.masksToBounds = true
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = notes[indexPath.row]
        let sheat = UIAlertController(title: "Что сделать с заметкой?",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        sheat.addAction(UIAlertAction(title: "Отмена",
                                      style: .cancel,
                                      handler: nil))
        sheat.addAction(UIAlertAction(title: "Редактировать",
                                      style: .default,
                                      handler: { _ in
            let alert = UIAlertController(title: "Редактировать",
                                          message: "Измените вашу заметку",
                                          preferredStyle: .alert)
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.tittle
            alert.addAction(UIAlertAction(title: "Сохранить",
                                          style: .cancel,
                                          handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                self?.updateItem(item: item, newName: newName)
            }))
            self.present(alert, animated: true)
        }))
        sheat.addAction(UIAlertAction(title: "Удалить",
                                      style: .destructive,
                                      handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        present(sheat, animated: true)
    }
    
}
