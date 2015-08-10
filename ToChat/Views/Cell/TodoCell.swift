//
//  TodoCell.swift
//  ToChat
//
//  Created by syfll on 15/8/10.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//
//  用在 ToDo_TypeViewController和ToDo_AllViewController
import UIKit


let JF_TodoCell_ReuseIdentifier = "TodoCell"
class TodoCell: UITableViewCell {
    private func commonInit() {
        userView.backgroundColor = UIColor.clearColor()
        
        userView.contentMode = .ScaleAspectFit
        userView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        shortEventLabel.textAlignment  = NSTextAlignment.Left
        shortEventLabel.font = UIFont.systemFontOfSize(12)
        shortEventLabel.textColor = UIColor.blackColor()
        shortEventLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        eventTimeLabel.textAlignment  = NSTextAlignment.Left
        eventTimeLabel.font = UIFont.systemFontOfSize(8)
        eventTimeLabel.textColor = UIColor.groupTableViewBackgroundColor()
        eventTimeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        userName.textAlignment  = NSTextAlignment.Left
        userName.font = UIFont.systemFontOfSize(8)
        userName.textColor = UIColor.grayColor()
        userName.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        commentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        commentButton.titleLabel?.font = UIFont.systemFontOfSize(8)
        commentButton.backgroundColor = UIColor.clearColor()
        //commentButton.imageView?.image = UIImage(named: "time_clock_icon")
        
        self.contentView.addSubview(userView)
        self.contentView.addSubview(shortEventLabel)
        self.contentView.addSubview(eventTimeLabel)
        self.contentView.addSubview(userName)
        self.contentView.addSubview(commentButton)
        
        userView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(5)
            make.top.equalTo(self.contentView).offset(5)
            make.bottom.equalTo(self.contentView).offset(-5)
            make.height.width.equalTo(44)
        }
        
        userName.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.eventTimeLabel.snp_right).offset(2)
            make.centerY.equalTo(self.eventTimeLabel)
        }
        
        shortEventLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.userView.snp_right).offset(5)
            make.top.equalTo(self.contentView).offset(5)
        }
        
        eventTimeLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.userView.snp_right).offset(5)
            make.bottom.equalTo(self.contentView).offset(-5)
        }
        commentButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.userName.snp_right).offset(5)
            make.centerY.equalTo(self.eventTimeLabel)
        }
        
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private let userView = UIImageView()
    private let shortEventLabel = UILabel()
    private let eventTimeLabel = UILabel()
    private let userName = UILabel()
    
    var object:TodoItem?{
        didSet{
            userView.image = object?.userImage
            shortEventLabel.text = object?.shortEvent
            eventTimeLabel.text = object?.eventDate
            userName.text = object?.userName
            commentButton.setTitle("0", forState: UIControlState.Normal)
            commentButton.setImage(UIImage(named: "time_clock_icon"), forState: UIControlState.Normal)
            commentButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        }
    }
    
    //包含了一张评论图片和评论数量的按钮（不能点击）
    private let commentButton = UIButton()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
