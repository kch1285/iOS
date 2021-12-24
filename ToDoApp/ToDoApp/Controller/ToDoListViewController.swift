//
//  ViewController.swift
//  ToDoApp
//
//  Created by chihoooon on 2021/12/22.
//

import UIKit
import SnapKit
import CoreData

class ToDoListViewController: UIViewController {
    private var toDoListArray: [ToDoListModel] = []
    // 커스텀 타입은 UserDefaults에 저장 안됨
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("222")
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
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
        toDoListTableView.reloadData()
    }
    
    private func loadItems(with request: NSFetchRequest<ToDoListModel> = ToDoListModel.fetchRequest()) {
        do {
            toDoListArray = try context.fetch(request)
        }
        catch {
            print(error.localizedDescription)
        }
        toDoListTableView.reloadData()
    }
    
    @objc private func didTapAddButton() {
        var textField = UITextField()
        let alert = UIAlertController(title: "할 일을 추가하세요.", message: nil, preferredStyle: .alert)
        let add = UIAlertAction(title: "추가하기", style: .default) { [weak self] action in
            guard let item = textField.text, item != "" else {
                return
            }
            
            let newItem = ToDoListModel(context: self!.context)
            newItem.title = item
            newItem.checked = false
            
            self?.toDoListArray.append(newItem)
            self?.saveItems()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .destructive) { _ in
            textField.resignFirstResponder()
        }
        
        alert.addTextField { field in
            field.placeholder = "할 일을 추가하세요."
            textField = field
        }
        alert.addAction(add)
        alert.addAction(cancel)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        
        headerView.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalTo(headerView).inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
            make.centerY.equalTo(headerView)
            make.height.equalTo(60)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}

//MARK: - UITableViewDelegate
extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        /// 테이블과 CoreData에서 삭제
        /// context.delete(toDoListArray[indexPath.row])
        /// toDoListArray.remove(at: indexPath.row)
        
        toDoListArray[indexPath.row].checked = !toDoListArray[indexPath.row].checked
        saveItems()
    }
}

//MARK: - UISearchBarDelegate
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text != "" else {
            return
        }
        
        let request: NSFetchRequest<ToDoListModel> = ToDoListModel.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
