//
//  ViewController.swift
//  TableViewHeader-Tutorial
//
//  Created by YouTube on 2023-04-12.
//

import UIKit

struct TodoSection {
    let sectionTitle: String
    var todos: [String]
}

class ViewController: UIViewController {

    // MARK: - Variables
    private var todoSections: [TodoSection] = [
        TodoSection(sectionTitle: "In Progress", todos: [
            "Take out garbage",
            "Clean room",
            "Study programming"
        ]),
        TodoSection(sectionTitle: "Completed", todos: [
            "Walk Dog",
            "Wash car",
            "Meal prep"
        ]),
    ]
    
    // MARK: - UI Components
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .systemGray
        tableView.register(CellHeader.self, forHeaderFooterViewReuseIdentifier: CellHeader.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsSelection = false
        return tableView
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let tableHeaderView = TableViewHeadwer(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250))
        self.tableView.tableHeaderView = tableHeaderView
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0.0 }
        
        let tableViewFooter = TableViewFooter(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        self.tableView.tableFooterView = tableViewFooter
        if #available(iOS 15.0, *) { tableView.sectionHeaderTopPadding = 0.0 }
        
        
        tableViewFooter.onButtonClicked = { [weak self] in
            let sectionNo = Int.random(in: 0...25)
//            self?.items.append(sectionNo.description)
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
    
    // MARK: - Selectors
}

// MARK: - TableView Functions
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - HEADER CELLS
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.todoSections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CellHeader.identifier) as? CellHeader else {
            fatalError("Failed to create header cell.")
        }
        let headerTitle = self.todoSections[section].sectionTitle
        header.configure(with: headerTitle)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "my title"
//    }
//
    
    // MARK: - NORMAL CELL
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoSections[section].todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .secondarySystemBackground
        
        let title = self.todoSections[indexPath.section].todos[indexPath.row]
        cell.textLabel?.text = title
        
        return cell
    }
    
    
    // MARK: - FOOTER CELLS
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 55
    }
}
