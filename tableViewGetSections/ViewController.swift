//
//  ViewController.swift
//  tableViewGetSections
//
//  Created by Daniel Hjärtström on 2018-06-14.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

enum SortType {
    case ascending, descending
}

extension Array where Element : Equatable {
    func mapArrayToSectionArray(sorted: Bool, sortBy: SortType) -> [[Element]] {
        var dict = [String: [Element]]()
        _ = self.map { dict[String(describing: ($0 as! String).first)] = []}
        _ = self.map { dict[String(describing: ($0 as! String).first)]?.append($0) }
        
        let result = dict.map { $0.value }
        
        if sorted {
            return result.sorted(by: { (lhs, rhs) -> Bool in
                if sortBy == .ascending {
                    return (lhs as! [String]).first! < (rhs as! [String]).first!
                } else {
                    return (lhs as! [String]).first! > (rhs as! [String]).first!
                }
            })
        }te
        return result
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arr: [String] = ["Ba", "Bb","Aa","Ak","Aw","Du","Cl","Ee","Ff","Gg","Hh","Jj"]
    var items: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        items = arr.mapArrayToSectionArray(sorted: true, sortBy: .ascending)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let title = items[section].first?.first else { return "" }
        return String(title)
    }
    
}
