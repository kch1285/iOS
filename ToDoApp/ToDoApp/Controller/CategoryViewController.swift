//
//  CategoryViewController.swift
//  ToDoApp
//
//  Created by chihoooon on 2021/12/24.
//

import UIKit
import SnapKit
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CategoryViewController: UIViewController {
    private var categories: Results<Category>?
    private let realm = try! Realm()
    
    private let categoryTableView: UITableView = {
        let tableView = UITableView()
      //  tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        tableView.backgroundColor = .clear
        tableView.rowHeight = 80
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        setUpNavagationBar()
        loadCategories()
    }
    
    private func setUpTableView() {
        view.setGradient(colors: [UIColor(named: "gradient_start")!.cgColor, UIColor(named: "gradient_end")!.cgColor])
        title = "To Do List"
        view.addSubview(categoryTableView)
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    private func setUpNavagationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = .label
    }
    
    private func save(category: Category) {
        do {
            try realm.write({
                realm.add(category)
            })
        }
        catch {
            print(error.localizedDescription)
        }
        categoryTableView.reloadData()
    }
    
    private func loadCategories() {
        categories = realm.objects(Category.self)
        /// Realm을 사용하면 밑의 CoreData를 사용했을 때의 긴 라인을 위의 한 라인으로 대체할 수 있다.
//        let request: NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//            categories = try context.fetch(request)
//        }
//        catch {
//            print(error.localizedDescription)
//        }
        
        categoryTableView.reloadData()
    }
    
    @objc private func didTapAddButton() {
        var textField = UITextField()
        let alert = UIAlertController(title: "카테고리를 추가하세요.", message: nil, preferredStyle: .alert)
        let add = UIAlertAction(title: "추가하기", style: .default) { [weak self] action in
            guard let item = textField.text, item != "" else {
                return
            }
            
            let newCategory = Category()
            newCategory.name = item
            newCategory.color = UIColor.randomFlat().hexValue()
            /// Results 타입은 auto-updating container type이므로 append 필요 없음
//            self?.categories.append(newCategory)
            self?.save(category: newCategory)
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
extension CategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = categories?[indexPath.row].name
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "FFFFFF")
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ToDoListViewController()
        vc.selectedCategory = categories?[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - SwipeTableViewCellDelegate
extension CategoryViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [weak self] action, indexPath in
            if let deleteCategory = self?.categories?[indexPath.row] {
                do {
                    try self?.realm.write {
                        self?.realm.delete(deleteCategory)
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete-circle")
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}
