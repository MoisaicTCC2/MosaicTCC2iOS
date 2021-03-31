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
    private var mockStudy = [StudiesModel.Patient]()
    private let viewModel = StudiesListViewModel()
    private var filteredData = [StudiesModel.Patient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studiesTableView.dataSource = self
        studiesTableView.delegate = self
        studiesTableView.tableFooterView = UIView()
        let cellNib = UINib(nibName: "\(StudiesTableViewCell.self)", bundle: nil)
        studiesTableView.register(cellNib, forCellReuseIdentifier: "\(StudiesTableViewCell.self)")
        bindStatus()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getStudies()
    }
    
    private func bindStatus() {
        viewModel.studiesBindable.bind { state in
            switch state {
            case .success(let response):
                self.getSuccess(response: response)
            case .error:
                self.getError()
            case .none:
                print("erro inesperado")
            }
        }
    }
    
    private func getSuccess(response: [StudiesModel.Patient]) {
        print(response)
        mockStudy = response
        filteredData = mockStudy
        studiesTableView.reloadData()
    }
    
    private func getError() {
        
    }
    
    private func setEmptyMessage(_ message: String) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        label.textAlignment = .center
        label.textColor = .systemGray
        label.text = message
        label.font = .boldSystemFont(ofSize: 26)
        label.sizeToFit()
        
        self.studiesTableView.backgroundView = label
        self.studiesTableView.separatorStyle = .none
    }
    
    private func restoreTableViewPopulated() {
        self.studiesTableView.backgroundView = nil
        self.studiesTableView.separatorStyle = .singleLine
    }

}

extension StudiesListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData.count == 0 {
            setEmptyMessage("Ainda não há dados")
        } else {
            restoreTableViewPopulated()
        }
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(StudiesTableViewCell.self)", for: indexPath) as! StudiesTableViewCell
        cell.patientNameLabel.text = mockStudy[indexPath.row].patientName?.replacingOccurrences(of: "^", with: " ")
        cell.patientIdLabel.text = mockStudy[indexPath.row].patientID
        cell.instanceImageView.downloaded(from: mockStudy[indexPath.row].studies?[0].series?[0].files?[0].imageURL ?? "")
        return cell
    }
    
}

extension StudiesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let controller = UIStoryboard(name: "StudiesDetail", bundle: nil).instantiateViewController(identifier: "StudiesDetail") as! StudiesDetailViewController
        controller.patient = filteredData[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension StudiesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            let filteredData = self.mockStudy.filter { ($0.patientName?.lowercased().contains(searchText.lowercased()) ?? true) }
            
            self.filteredData = filteredData
        } else {
            self.filteredData = self.mockStudy
        }
        
        self.studiesTableView.reloadData()
    }
}
