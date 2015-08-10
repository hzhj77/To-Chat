//
//  TodoItem.swift
//  ToChat
//
//  Created by syfll on 15/8/10.
//  Copyright (c) 2015年 JFT0M. All rights reserved.
//

import Foundation
import UIKit.UIImage

public struct TodoItem{
    public var userImage: UIImage
    public var shortEvent: String
    public var eventDate: String
    public var userName: String
    public var comment: [String]?
    public var commentNum: Int{
        get{
            if (comment != nil) {
                return comment!.count
            }
            else{
                return 0;
            }
        }
    }
    // MARK: - Init
    public init(userImage: UIImage,shortEvent: String,eventDate: String,userName: String, comment: [String]? = nil) {
        self.userImage = userImage
        self.shortEvent = shortEvent
        self.eventDate = eventDate
        self.userName = userName
        self.comment = comment
    }
    
    
    
}