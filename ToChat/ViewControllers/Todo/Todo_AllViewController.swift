//
//  Todo_AllViewController.swift
//  ToChat
//
//  Created by syfll on 15/8/10.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

import UIKit
let kPaddingLeftWidth :CGFloat  = 15.0
@objc class Todo_AllViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.title = "按列表查看";
        tableView.registerClass(TodoCell.self, forCellReuseIdentifier: JF_TodoCell_ReuseIdentifier)
        tableView.backgroundColor = UIColor.whiteColor()

        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell  = tableView.dequeueReusableCellWithIdentifier(JF_TodoCell_ReuseIdentifier, forIndexPath: indexPath) as! TodoCell
        let item = TodoItem(userImage: UIImage(named: "found_people")!, shortEvent: "第一天扫地", eventDate: "9/8", userName: "JFT0M")
        cell.object = item
        tableView.addLineforPlainCell(cell, forRowAtIndexPath: indexPath, withLeftSpace: kPaddingLeftWidth)
        return cell
    }

}
