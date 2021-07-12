//
//  ViewController.swift
//  Countdown Timer
//
//  Created by chihoooon on 2021/05/19.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var count = 30
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timmer), userInfo: nil, repeats: true)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .blue
        cell.textLabel?.text = "kkkk"
        return cell
    }
    
    @objc func timmer(){
        if count > 0{
            print(count)
            count -= 1
        }
    }
}

