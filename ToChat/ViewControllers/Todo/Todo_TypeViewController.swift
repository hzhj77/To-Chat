// For License please refer to LICENSE file in the root of Persei project

import UIKit
import QuartzCore
import CoreImage


@objc class Todo_TypeViewController: UITableViewController {
    //private weak var imageView: UIImageView!
    private weak var menu: MenuView!
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(TodoCell.self, forCellReuseIdentifier: JF_TodoCell_ReuseIdentifier)
       
        loadMenu()
        //imageView = UIImageView
        title = model.description
        //imageView.image = model.image
    }
    
    private func loadMenu() {
        let menu = MenuView()
        menu.delegate = self
        menu.items = items
        
        tableView.addSubview(menu)
        
        self.menu = menu
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //print(imageView.bounds.size)
    }
    
    // MARK: - Items
    private let items = (0..<7 as Range).map {
        MenuItem(image: UIImage(named: "menu_icon_\($0)")!,title: "运动")
    }
    
    // MARK: - Model
    private var model: ContentType = ContentType.Films {
        didSet {
            title = model.description
            
            if isViewLoaded() {
                let center: CGPoint = {
                    let itemFrame = self.menu.frameOfItemAtIndex(self.menu.selectedIndex!)
                    let itemCenter = CGPoint(x: itemFrame.midX, y: itemFrame.maxY)
                    var convertedCenter = self.tableView.convertPoint(itemCenter, fromView: self.menu)
                    //convertedCenter.y = 0
                    convertedCenter.y = 200
                    return convertedCenter
                }()
                let transition = CircularRevealTransition(layer: self.tableView.layer, center: center)
                transition.start()
                
//                let center: CGPoint = {
//                    let itemFrame = self.menu.frameOfItemAtIndex(self.menu.selectedIndex!)
//                    let itemCenter = CGPoint(x: itemFrame.midX, y: itemFrame.midY)
//                    //var convertedCenter = self.imageView.convertPoint(itemCenter, fromView: self.menu)
//                    //convertedCenter.y = 0
//
//                    //return convertedCenter
//                }()
//                
//                let transition = CircularRevealTransition(layer: imageView.layer, center: center)
//                transition.start()
//                
//                imageView.image = model.image
            }
        }
    }
    
    // MARK: - Actions

    private func switchMenu() {
        menu.setRevealed(!menu.revealed, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 9;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(JF_TodoCell_ReuseIdentifier, forIndexPath: indexPath) as! TodoCell
        let item = TodoItem(userImage: UIImage(named: "found_people")!, shortEvent: "第一天扫地", eventDate: "9/8", userName: "JFT0M")
        cell.object = item
        tableView.addLineforPlainCell(cell, forRowAtIndexPath: indexPath, withLeftSpace: kPaddingLeftWidth)
        return cell
    }
    
}

// MARK: - MenuViewDelegate
extension Todo_TypeViewController: MenuViewDelegate {
    func menu(menu: MenuView, didSelectItemAtIndex index: Int) {
        model = model.next()
    }
}