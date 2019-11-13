//
//  SimplePopoverViewController.swift
//  PublicServiceLeader
//
//  Created by Crep on 6/19/18.
//  Copyright © 2018 NhatCuong. All rights reserved.
//

import UIKit

class SimplePopoverViewController: UIViewController, NCBaseViewController, PopoverControllerProtocol {
    
    var dataSource: [ObjectForPopoverSource]!
    var type: PopoverType = .unknown
    var delegate: UIPopoverPresentationControllerDelegate?
    var contentSize: CGSize!
    var sourceView: UIView!
    var sourceRect: CGRect!
    var direction: UIPopoverArrowDirection!
    var actionDelegate: ReceiveActionFromPopoverProtocol?
    var selectedIndex: Int = -1
    
    @IBOutlet weak var tableView: UITableView!
    ///Cell identifier
    fileprivate let CELL_IDENTIFIER: String = String.className(SimplePopoverCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cellNib = UINib(nibName: self.CELL_IDENTIFIER, bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: self.CELL_IDENTIFIER)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
}

extension SimplePopoverViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELL_IDENTIFIER, for: indexPath) as! SimplePopoverCell
        cell.labelContent.text = self.dataSource[indexPath.row].displayName
        cell.setChosen(indexPath.row == self.selectedIndex)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndex = indexPath.row
        tableView.reloadData()
        
        guard let delegate = self.actionDelegate else { return }
        delegate.didReceiveActionAt(index: indexPath.row, type: self.type)
        self.dismiss(animated: true, completion: nil)
    }
}

