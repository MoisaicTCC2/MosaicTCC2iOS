//
//  StudiesListViewController.swift
//  MosaicTCC2iOS
//
//  Created by Wesley Araujo on 19/03/21.
//  Copyright © 2021 Wesley Araujo. All rights reserved.
//

import UIKit

class StudiesListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var studiesTableView: UITableView!
    private let mockStudy = [["name": "teste1", "id": "1234"], ["name": "teste2", "id": "4567"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studiesTableView.dataSource = self
        studiesTableView.delegate = self
        studiesTableView.tableFooterView = UIView()
        let cellNib = UINib(nibName: "\(StudiesTableViewCell.self)", bundle: nil)
        studiesTableView.register(cellNib, forCellReuseIdentifier: "\(StudiesTableViewCell.self)")
    }

}

extension StudiesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockStudy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(StudiesTableViewCell.self)", for: indexPath) as! StudiesTableViewCell
        print(mockStudy[indexPath.row]["name"] ?? "")
        cell.patientNameLabel.text = mockStudy[indexPath.row]["name"]
        cell.patientIdLabel.text = mockStudy[indexPath.row]["id"]
        return UITableViewCell()
    }
    
}

extension StudiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148.0
    }
}
