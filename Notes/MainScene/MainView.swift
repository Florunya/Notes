//
//  MainView.swift
//  Notes
//
//  Created by Флора Гарифуллина on 30.01.2024.
//

import Foundation
import UIKit

class MainView: UIView{
    
    let tableView = UITableView()
    let emptyLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        backgroundColor = .white
        tableView.rowHeight = 60
        addSubview(tableView)
        
        emptyLabel.text = "Список заметок пуст"
        emptyLabel.textColor = .lightGray
        emptyLabel.textAlignment = .center
        emptyLabel.sizeToFit()
        addSubview(emptyLabel)
        
        makeConstraints()
        
//        let label = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
        emptyLabel.text = "Список заметок пуст"
        emptyLabel.textColor = .lightGray
        emptyLabel.textAlignment = .center
        emptyLabel.sizeToFit()
//        emptyLabel.backgroundView = emptyLabel
//        emptyLabel.separatorStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isListEmpty(){
        let label = UILabel(frame: CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height))
        label.text = "Список заметок пуст"
        label.textColor = .lightGray
        label.textAlignment = .center
        label.sizeToFit()
        label.isHidden = false
        tableView.backgroundView = label
        tableView.separatorStyle = .none
    }
    
    func makeConstraints(){
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        emptyLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        emptyLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        emptyLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        emptyLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}
