//
//  ViewController.swift
//  ToDoApp
//
//  Created by chihoooon on 2021/12/22.
//

import UIKit
import SnapKit

class ToDoListViewController: UIViewController {
    private var toDoListArray: [ToDoListModel] = []
    // 커스텀 타입은 UserDefaults에 저장 안됨
    private let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    private let toDoListTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(ToDoListTableViewCell.self, forCellReuseIdentifier: ToDoListTableViewCell.identifier)
        tableview.backgroundColor = .clear
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpNavagationBar()
        loadItems()
    }
    
    private func setUpNavagationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }

    private func setUpTableView() {
        title = "To Do List"
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        view.addSubview(toDoListTableView)
        toDoListTableView.dataSource = self
        toDoListTableView.delegate = self
        toDoListTableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(toDoListArray)
            try data.write(to: dataFilePath!)
        }
        catch {
            print(error.localizedDescription)
        }
        toDoListTableView.reloadData()
    }
    
    private func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                toDoListArray = try decoder.decode([ToDoListModel].self, from: data)
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func didTapAddButton() {
        var textField = UITextField()
        let alert = UIAlertController(title: "할 일을 추가하세요.", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "추가하기", style: .default) { [weak self] action in
            guard let item = textField.text, item != "" else {
                return
            }
            let newItem = ToDoListModel(title: item)
            self?.toDoListArray.append(newItem)
            self?.saveItems()
        }
        
        alert.addTextField { field in
            field.placeholder = "할 일을 추가하세요."
            textField = field
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - UITableViewDataSource
extension ToDoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListTableViewCell.identifier, for: indexPath) as! ToDoListTableViewCell
        cell.textLabel?.text = toDoListArray[indexPath.row].title
        cell.accessoryType = toDoListArray[indexPath.row].checked ? .checkmark : .none
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        toDoListArray[indexPath.row].checked = !toDoListArray[indexPath.row].checked
        saveItems()
    }
}
