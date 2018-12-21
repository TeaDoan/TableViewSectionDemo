//
//  ContactsTableViewController.swift
//  TableViewSectionDemo
//
//  Created by Thao Doan on 12/21/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    let reuseIdentifierCell = "cell"
    var contactName = ["Andy","Andrew","Babb","Battles","Carlos","Dave","Dentom","Emily","Fox","Garza","Gary","Hamilton","Jonny","Wilson","Jackson"]
    var phone = [650000001,650000002,650000003,650000004,650000005,650000006,650000007,650000008,650000009,650000010,650000011,650000012,650000013,650000014,650000015]
     let phoneIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var phoneDict = [String: [String]]()
    var contactSectionTitle = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       createContactDict()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return contactSectionTitle.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       let phoneKey = contactSectionTitle[section]
        guard let phoneValues = phoneDict[phoneKey] else {
            return 0
        }
        return phoneValues.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactSectionTitle[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierCell , for: indexPath)
        let phoneKey = contactSectionTitle[indexPath.section]
        let phoneNumberKey = phone[indexPath.section]
        if let phoneValues = phoneDict[phoneKey]{
        cell.textLabel?.text = phoneValues[indexPath.row]
        cell.detailTextLabel?.text = String(phoneNumberKey)
        }
        
      
        return cell
    }
    
    func createContactDict() {
        for name in contactName {
            let firstIndex = name.index(name.startIndex, offsetBy: 1)
            let nameKey = String(name[..<firstIndex])
            if var nameValues = phoneDict[nameKey] {
                nameValues.append(name)
                phoneDict[nameKey] = nameValues
            } else {
                phoneDict[nameKey] = [name]
            }
        }
        contactSectionTitle = [String](phoneDict.keys)
        contactSectionTitle = contactSectionTitle.sorted(by: { $0 < $1})
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = contactSectionTitle.index(of: title) else {
            return -1
        }
        return index
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return phoneIndexTitles
    }

}
