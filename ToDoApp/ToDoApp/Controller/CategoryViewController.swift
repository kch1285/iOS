//
//  CategoryViewController.swift
//  ToDoApp
//
//  Created by chihoooon on 2021/12/24.
//

import UIKit
import SnapKit
import RealmSwift

class CategoryViewController: UIViewController {
    private var categories: Results<Category>?
    private let realm = try! Realm()
    
    private let categoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.backgroundColor = .clear
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name
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
