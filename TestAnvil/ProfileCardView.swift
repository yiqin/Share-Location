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
    
    var screenNameLabel : UILabel!
    
    private let profileBackgroundImageSize : CGFloat = 140
    private let profileImageSize : CGFloat = 134
    
    
    var requestButton : UIButton!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
        clipsToBounds = true
        backgroundColor = UIColor(fromHexString: "f0f0f0")
        
        let tempColor = RandomColorGenerator.getColor()
        
        tempView = UIView(frame: CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetWidth(frame)*0.45))
        tempView.backgroundColor = tempColor
        addSubview(tempView)
        
        let tempView2 = UIView(frame: CGRectMake((CGRectGetWidth(tempView.frame)-profileBackgroundImageSize)*0.5, CGRectGetMaxY(tempView.frame)-profileBackgroundImageSize*0.5, profileBackgroundImageSize, profileBackgroundImageSize))
        tempView2.backgroundColor = UIColor.whiteColor()
        tempView2.clipsToBounds = true
        tempView2.layer.cornerRadius = profileBackgroundImageSize*0.5
        addSubview(tempView2)
        
        let yPadding : CGFloat = 20
        
        screenNameLabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(tempView2.frame)+yPadding, CGRectGetWidth(frame), 21))
        screenNameLabel.font = UIFont(name: "OpenSans-Semibold", size: 17.0)
        screenNameLabel.textAlignment = NSTextAlignment.Center
        screenNameLabel.textColor = UIColor(fromHexString: "4d4d4d")
        addSubview(screenNameLabel)
        
        /*
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.cancelButton.frame = CGRectMake(xPadding, CGRectGetHeight(self.view.frame)-bottomPadding+10, CGRectGetWidth(self.view.frame)-2*xPadding, bottomPadding-20);
        self.cancelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.cancelButton addTarget:self action:@selector(pressedCancel) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelButton setBackgroundColor:[UIColor colorFromHexString:@"f0f0f0"]];
        self.cancelButton.layer.cornerRadius = 8;
        self.cancelButton.titleLabel.font=[UIFont fontWithName:@"OpenSans-Semibold" size:17.0];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        */
        
        requestButton = UIButton()
        requestButton.frame = CGRectMake(0, CGRectGetHeight(frame)-21-21, CGRectGetWidth(frame), 21)
        requestButton.addTarget(self, action: "pressedRequestButton", forControlEvents: UIControlEvents.TouchUpInside)
        requestButton.layer.cornerRadius = 8.0
        requestButton.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17.0)
        requestButton.setTitleColor(tempColor, forState: UIControlState.Normal)
        requestButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        requestButton.setTitle("Ask for Location", forState: UIControlState.Normal)
        addSubview(requestButton)
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
        
        screenNameLabel.text = user.screenName
    }
    
    func pressedRequestButton() {
        
        let price = "0.3"
        
        let alert = UIAlertView()
        alert.delegate = self
        alert.title = "Alert"
        alert.message = "You will will be charge $" + price + "to view the location, continue?"
        alert.addButtonWithTitle("Yes")
        alert.addButtonWithTitle("Cancel")
        alert.show()
        // yes
        //
    }
    
    
    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
        
        switch buttonIndex{
            
        case 1:
            NSLog("Retry");
            println("lalala")
            break;
        case 0:
            NSLog("Dismiss");
            break;
        default:
            NSLog("Default");
            break;
            //Some code here..
            
        }
    }
}
