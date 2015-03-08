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
    
    var moenyTotalLabel : UILabel!
    var rateLabel : UILabel!
    var lookupsLabel: UILabel!
    
    
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
        
        screenNameLabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(tempView2.frame)+yPadding*0.5, CGRectGetWidth(frame), 21))
        screenNameLabel.font = UIFont(name: "OpenSans-Regular", size: 17.0)
        screenNameLabel.textAlignment = NSTextAlignment.Center
        screenNameLabel.textColor = UIColor(fromHexString: "4d4d4d")
        addSubview(screenNameLabel)
        
        
        moenyTotalLabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(screenNameLabel.frame)+yPadding*2, CGRectGetWidth(frame), 32))
        moenyTotalLabel.font = UIFont(name: "OpenSans-Semibold", size: 20.0)
        moenyTotalLabel.textAlignment = NSTextAlignment.Center
        moenyTotalLabel.textColor = UIColor(fromHexString: "4d4d4d")
        addSubview(moenyTotalLabel)
        
        rateLabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(moenyTotalLabel.frame)+yPadding*0.5, CGRectGetWidth(frame), 32))
        rateLabel.font = UIFont(name: "OpenSans-Semibold", size: 20.0)
        rateLabel.textAlignment = NSTextAlignment.Center
        rateLabel.textColor = UIColor(fromHexString: "4d4d4d")
        addSubview(rateLabel)
        
        lookupsLabel = UILabel(frame: CGRectMake(0, CGRectGetMaxY(rateLabel.frame)+yPadding*0.5, CGRectGetWidth(frame), 32))
        lookupsLabel.font = UIFont(name: "OpenSans-Semibold", size: 20.0)
        lookupsLabel.textAlignment = NSTextAlignment.Center
        lookupsLabel.textColor = UIColor(fromHexString: "4d4d4d")
        addSubview(lookupsLabel)
        
        
        
        
        
        
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
        requestButton.frame = CGRectMake(0, CGRectGetHeight(frame)-21-21-15, CGRectGetWidth(frame), 21)
        requestButton.addTarget(self, action: "pressedRequestButton", forControlEvents: UIControlEvents.TouchUpInside)
        requestButton.layer.cornerRadius = 8.0
        requestButton.titleLabel?.font = UIFont(name: "OpenSans-Semibold", size: 17.0)
        requestButton.setTitleColor(tempColor, forState: UIControlState.Normal)
        requestButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Highlighted)
        requestButton.setTitle("Ask for Location", forState: UIControlState.Normal)
        addSubview(requestButton)
        
        
        let temptemptempt = (CGRectGetMinY(requestButton.frame)-CGRectGetMaxY(lookupsLabel.frame))*0.5+CGRectGetMaxY(lookupsLabel.frame)
        
        
        let tempViewView = UIView(frame: CGRectMake(65, temptemptempt, CGRectGetWidth(frame)-130, 2))
        tempViewView.backgroundColor = tempColor
        tempViewView.layer.cornerRadius = 1.0
        addSubview(tempViewView)
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
        
        
        
        
        
        moenyTotalLabel.text = user.moneyTotalString
        
        rateLabel.text = user.rateString
        
        lookupsLabel.text = user.lookupsString
        
        
        
        self.user = user
    }
    
    func pressedRequestButton() {
        
        let price = user.raterateString
        
        let alert = UIAlertView()
        alert.delegate = self
        alert.title = "LOCASHION"
        alert.message = "You will will be charge $" + price + " to view the location, continue?"
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
            self.sendSomethingThrough()
            break;
        default:
            NSLog("Default");
            break;
            //Some code here..
            
        }
    }
    
    func sendSomethingThrough() {
        println(user.objectId)
        NSNotificationCenter.defaultCenter().postNotificationName("dismissLeadingBoardScrollView", object: nil, userInfo:["message":user.objectId])
    }
}
