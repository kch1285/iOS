//
//  CategoryViewController.swift
//  ToDoApp
//
//  Created by chihoooon on 2021/12/24.
//

import UIKit
import SnapKit
import CoreData

class CategoryViewController: UIViewController {
    private var categories: [`Category`] = []
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    private func saveCategories() {
        do {
            try context.save()
        }
        catch {
            print(error.localizedDescription)
        }
        categoryTableView.reloadData()
    }
    
    private func loadCategories() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(request)
        }
        catch {
            print(error.localizedDescription)
        }
        categoryTableView.reloadData()
    }
    
    @objc private func didTapAddButton() {
        var textField = UITextField()
        let alert = UIAlertController(title: "카테고리를 추가하세요.", message: nil, preferredStyle: .alert)
        let add = UIAlertAction(title: "추가하기", style: .default) { [weak self] action in
            guard let item = textField.text, item != "" else {
                return
            }
            
            let newCategory = Category(context: self!.context)
            newCategory.name = item
            self?.categories.append(newCategory)
            self?.saveCategories()
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
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
}

//MARK: - UITableViewDelegate
extension CategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ToDoListViewController()
        vc.selectedCategory = categories[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
