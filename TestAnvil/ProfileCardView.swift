//
//  ProfileCardView.swift
//  TestAnvil
//
//  Created by Yi Qin on 3/7/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

import UIKit

class ProfileCardView: UIView {
    
    var user : TestAnvilUser!
    
    var userProfileImageView : UIImageView!
    
    var tempView:UIView!
    
    private let profileBackgroundImageSize : CGFloat = 140
    private let profileImageSize : CGFloat = 134
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = UIColor(fromHexString: "f0f0f0")
        
        tempView = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetWidth(frame)*0.45))
        tempView.backgroundColor = RandomColorGenerator.getColor()
        addSubview(tempView)
        
        let tempView2 = UIView(frame: CGRectMake((CGRectGetWidth(tempView.frame)-profileBackgroundImageSize)*0.5, CGRectGetMaxY(tempView.frame)-profileBackgroundImageSize*0.5, profileBackgroundImageSize, profileBackgroundImageSize))
        tempView2.backgroundColor = UIColor.whiteColor()
        tempView2.clipsToBounds = true
        tempView2.layer.cornerRadius = profileBackgroundImageSize*0.5
        addSubview(tempView2)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUser(user:TestAnvilUser) {
        userProfileImageView = UIImageView(frame: CGRectMake((CGRectGetWidth(tempView.frame)-profileImageSize)*0.5, CGRectGetMaxY(tempView.frame)-profileImageSize*0.5, profileImageSize, profileImageSize))
        userProfileImageView.contentMode = UIViewContentMode.ScaleAspectFill
        userProfileImageView.layer.cornerRadius = profileImageSize*0.5
        userProfileImageView.clipsToBounds = true
        addSubview(userProfileImageView)
        
        userProfileImageView.image = user.profileImage.image
        
    }
    
}
