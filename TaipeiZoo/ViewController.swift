//
//  ViewController.swift
//  TaipeiZoo
//
//  Created by alex on 05/09/2017.
//  Copyright © 2017 alex. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController, NVActivityIndicatorViewable {

    // MARK: - Properties
    
    var model = AnimalModel()
    var tableView: UITableView!
    var image: UIImage?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imageVC = segue.destination.contents as? ImageViewController {
            if let image = image {
                imageVC.image = image
                if let indexPath = sender as? IndexPath {
                    imageVC.title = model.results?[indexPath.row].A_Pic01_ALT
                }
            }
        }
    }
    
    // MARK: - Private Implementation
    
    func initData() {
        guard let url = URL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=a3e2b221-75e0-45c1-8f97-75acbd43d613") else { return }
        startIndicatorAnimating()
        JsonManager.sharedInstance.getJsonObject(method: .get, url: url) { [weak self] jsonObject in
            self?.model.setData(jsonObject: jsonObject)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.stopAnimating()
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func initUI() {
        view.backgroundColor = UIColor(hex: 0x282828)
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 8
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(initData), for: .valueChanged)
        view.addSubview(tableView)
    }
    
    private func setUI() {
        let frameW = UIScreen.main.bounds.width
        let frameH = UIScreen.main.bounds.height
        let gap: CGFloat = 10
        tableView.frame = CGRect(x: gap, y: 20 + gap, width: frameW - 2 * gap, height: frameH - 20 - 2 * gap)
    }
    
    fileprivate func startIndicatorAnimating() {
        let size = CGSize(width: 70, height: 70)
        self.startAnimating(size,
                            message: "Loading...",
                            messageFont: UIFont.systemFont(ofSize: 20),
                            type: NVActivityIndicatorType(rawValue: 25),
                            color: .white,
                            padding: 0,
                            displayTimeThreshold: 0,
                            minimumDisplayTime: 0,
                            backgroundColor: UIColor.black.withAlphaComponent(0.8),
                            textColor: .white)
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: model.results?[indexPath.row].A_Pic01_URL ?? "") else { return }
        startIndicatorAnimating()
        image = nil
        JsonManager.sharedInstance.getImageData(method: .get, url: url) { [weak self] data in
            if let img = data as? UIImage {
                self?.image = img
            }
            DispatchQueue.main.async {
                self?.stopAnimating()
                tableView.deselectRow(at: indexPath, animated: true)
                if self?.image != nil { self?.performSegue(withIdentifier: "Show Image", sender: indexPath) }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.results?.count ?? 0
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "animalCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "animalCell")
        }
        
        cell?.textLabel?.text = model.results?[indexPath.row].A_Name_Ch ?? ""
        cell?.detailTextLabel?.text = model.results?[indexPath.row].A_Keywords ?? ""
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        return cell!
    }
}
