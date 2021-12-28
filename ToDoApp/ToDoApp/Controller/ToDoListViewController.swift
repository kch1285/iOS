//
//  ViewController.swift
//  ToDoApp
//
//  Created by chihoooon on 2021/12/22.
//

import UIKit
import SnapKit
import RealmSwift

class ToDoListViewController: UIViewController {
    private var toDoListArray: Results<Item>?
    private let realm = try! Realm()
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
    private let toDoSearchBar = UISearchBar()
    
    private let toDoListTableView: UITableView = {
        let tableview = UITableView()
        tableview.register(ToDoListTableViewCell.self, forCellReuseIdentifier: ToDoListTableViewCell.identifier)
        tableview.backgroundColor = .clear
        tableview.keyboardDismissMode = .onDrag
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        setUpNavagationBar()
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    private func setUpNavagationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    private func setUpTableView() {
        title = selectedCategory?.name
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        view.addSubview(toDoListTableView)
        toDoListTableView.dataSource = self
        toDoListTableView.delegate = self
        toDoListTableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func loadItems() {
        toDoListArray = selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true)
        /// Realm을 사용하면 밑의 CoreData를 사용했을 때의 긴 라인을 위의 한 라인으로 대체할 수 있다.
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory?.name as! CVarArg)
//
//        if let predicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
//        }
//        else {
//            request.predicate = categoryPredicate
//        }
//
//        do {
//            toDoListArray = try context.fetch(request)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
        toDoListTableView.reloadData()
    }
    
    @objc private func didTapAddButton() {
        var textField = UITextField()
        let alert = UIAlertController(title: "할 일을 추가하세요.", message: nil, preferredStyle: .alert)
        let add = UIAlertAction(title: "추가하기", style: .default) { [weak self] action in
            guard let item = textField.text, item != "" else {
                return
            }
            
            if let currentCategory = self?.selectedCategory {
                do {
                    try self?.realm.write({
                        let newItem = Item()
                        newItem.title = item
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    })
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            self?.toDoListTableView.reloadData()
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
        return toDoListArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToDoListTableViewCell.identifier, for: indexPath)
        if let item = toDoListArray?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.checked ? .checkmark : .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))

        toDoSearchBar.searchBarStyle = .minimal
        toDoSearchBar.delegate = self
        
        headerView.addSubview(toDoSearchBar)
        toDoSearchBar.snp.makeConstraints { make in
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
        view.endEditing(true)
        /// 테이블과 CoreData에서 삭제
        /// context.delete(toDoListArray[indexPath.row])
        /// toDoListArray.remove(at: indexPath.row)
        
        //toDoListArray?[indexPath.row].checked = !toDoListArray[indexPath.row].checked
        if let item = toDoListArray?[indexPath.row] {
            do {
                try realm.write({
                    item.checked = !item.checked
                    
                    /// realm의 데이터를 지우고싶다면
                    /// realm.write 로 update하고, delete로 지우기 (wirte 블록 안에 작성 )
                    // realm.delete(item)
                })
            }
            catch {
                print(error.localizedDescription)
            }
        }
        tableView.reloadData()
    }
}

//MARK: - UISearchBarDelegate
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text != "" else {
            return
        }

//        let request: NSFetchRequest<ToDoListModel> = ToDoListModel.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//        loadItems(with: request, predicate: predicate)
        /// 위의 라인들을 Realm을 사용하여 밑의 한 라인으로 사용가능
        toDoListArray = toDoListArray?.filter("title CONTAINS[cd] %@", text).sorted(byKeyPath: "dateCreated", ascending: true)
        toDoListTableView.reloadData()
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
