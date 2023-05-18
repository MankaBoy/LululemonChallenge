//
//  ViewController.swift
//  LululemonChallenge
//
//  Created by Noor Ali on 5/12/23.
//

import UIKit
enum ActionType {
    case addType
    case editType
}

class ViewController: UIViewController {
    @IBOutlet weak var tblView:
        UITableView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    let viewModel = ItemsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
        addItemButtonSetUp()
    }
    func addItemButtonSetUp() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: .add, style: .plain, target: self, action: #selector(navigateToAddNewItemVC))
    }

    @objc func navigateToAddNewItemVC() {
        moveToController()
    }
    
    @IBAction func segmnetedControlAction(_ sender: UISegmentedControl) {
        fetchDataReload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataReload()
    }
    
    func fetchDataReload() {
        viewModel.fetchDataFromDatabase(sortIndex: segmentControl.selectedSegmentIndex)
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "cell")
        let item = viewModel.getItemAtIndex(index: indexPath.row)
        cell?.textLabel?.text = item?.name
        return cell!
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = viewModel.getItemAtIndex(index: indexPath.row)
            if let item = item {
                viewModel.deleteItemAtIndex(item: item)
                fetchDataReload()
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.getItemAtIndex(index: indexPath.row)
        moveToController(item: item)
    }
    
    func moveToController(item: Item? = nil) {
        let st = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = st.instantiateViewController(withIdentifier: "AddOrEditItemViewController") as! AddOrEditItemViewController
        if let item = item {
            vc.selectedItem = item
            vc.actionType = ActionType.editType
        }
        else {
            vc.actionType = ActionType.addType
        }
        vc.completionHandler = {
            self.fetchDataReload()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

