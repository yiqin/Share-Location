//
//  InfoView.swift
//  MapStalk
//
//  Created by Nathan Pabrai on 3/7/15.
//  Copyright (c) 2015 Nathan Pabrai. All rights reserved.
//

import UIKit

class InfoView: UIView {
	//Outside properties
	var rateLabel:UILabel! = nil
	var hitsTodayLabel:UILabel! = nil
	var totalEarningsLabel:UILabel! = nil
	var enableLocationSwitch:UISwitch! = { var l = UISwitch(frame: CGRectMake(310, 5, 100, 50)); return l}()
	
    private let xPadding : CGFloat = 10
    
	 override  init(frame: CGRect) {
		super.init(frame:frame)
        
        
        var enableTitleLabel:UILabel = {  var l = UILabel(frame: CGRectMake(2, 5, 250, 20));
            l.text = "Enable Location uploading ";
            l.textColor = UIColor.whiteColor();
            l.font = UIFont(name: "OpenSans-Semibold", size: 17)
            return l}()
        
        
        
        let labelWidth = (CGRectGetWidth(frame)-2*xPadding)/3
        
        var rateTitleLabel:UILabel = {  var l = UILabel(frame: CGRectMake(self.xPadding, 55, labelWidth, 20));
            l.text = "Rate";
            l.font = UIFont(name: "OpenSans-Semibold", size: 15)
            l.textColor = UIColor.whiteColor()
            l.textAlignment = NSTextAlignment.Center
            return l}()

        
        var hitsTitleLabel:UILabel = {	var l = UILabel(frame: CGRectMake(self.xPadding+labelWidth, 55, labelWidth, 20));
            l.text = "Lookups" ;
            l.font = UIFont(name: "OpenSans-Semibold", size: 15)
            l.textAlignment = NSTextAlignment.Center
            l.textColor = UIColor.whiteColor();
            return l}();
        
        var earningsTitleLabel:UILabel = {	var l = UILabel(frame: CGRectMake(self.xPadding+2*labelWidth, 55, labelWidth, 20));
            l.text = "Earnings" ;
            l.font = UIFont(name: "OpenSans-Semibold", size: 15)
            l.textAlignment = NSTextAlignment.Center
            l.textColor = UIColor.whiteColor();
            return l}();
        
		addSubview(rateTitleLabel)
		addSubview(hitsTitleLabel)
		addSubview(earningsTitleLabel)
		addSubview(enableTitleLabel)
        
        
		addSubview(enableLocationSwitch)
        enableLocationSwitch.setOn(true, animated: true)
        
        
        
        
        let tempRateLabelOffsetY = CGRectGetMaxY(rateTitleLabel.frame)+10
        
        let tempViewWidth : CGFloat = 30
        let tempViewHeigth : CGFloat = 3;
        
        let tempOffsetForView = (labelWidth-tempViewWidth)*0.5
        
        let tempView1 = UIView(frame: CGRectMake(self.xPadding+tempOffsetForView, CGRectGetMaxY(rateTitleLabel.frame)+3, tempViewWidth, tempViewHeigth))
        tempView1.backgroundColor = UIColor(fromHexString: "3d5fc4")
        addSubview(tempView1)
        
        let tempView2 = UIView(frame: CGRectMake(self.xPadding+labelWidth+tempOffsetForView, CGRectGetMaxY(rateTitleLabel.frame)+3, tempViewWidth, tempViewHeigth))
        tempView2.backgroundColor = UIColor(fromHexString: "3d5fc4")
        addSubview(tempView2)
        
        let tempView3 = UIView(frame: CGRectMake(self.xPadding+2*labelWidth+tempOffsetForView, CGRectGetMaxY(rateTitleLabel.frame)+3, tempViewWidth, tempViewHeigth))
        tempView3.backgroundColor = UIColor(fromHexString: "3d5fc4")
        addSubview(tempView3)
        
        
		rateLabel = UILabel(frame: CGRectMake(self.xPadding, tempRateLabelOffsetY, labelWidth, 20));
		rateLabel.text = "6 cents"
        rateLabel.font = UIFont(name: "Lato-Regular", size: 15)
		rateLabel.textColor = UIColor.whiteColor()
        rateLabel.textAlignment = NSTextAlignment.Center
		addSubview(rateLabel)
		
		hitsTodayLabel = UILabel(frame: CGRectMake(self.xPadding+labelWidth, tempRateLabelOffsetY, labelWidth, 20));
		hitsTodayLabel.text = "11 hits"
        hitsTodayLabel.font = UIFont(name: "Lato-Regular", size: 15)
		hitsTodayLabel.textColor = UIColor.whiteColor()
        hitsTodayLabel.textAlignment = NSTextAlignment.Center
		addSubview(hitsTodayLabel)
	
		totalEarningsLabel = UILabel(frame: CGRectMake(self.xPadding+2*labelWidth, tempRateLabelOffsetY, labelWidth, 20));
		totalEarningsLabel.text = "$48.20"
        totalEarningsLabel.font = UIFont(name: "Lato-Regular", size: 15)
		totalEarningsLabel.textColor = UIColor.whiteColor()
        totalEarningsLabel.textAlignment = NSTextAlignment.Center
		addSubview(totalEarningsLabel)
		
		backgroundColor = UIColor.blackColor()
	}

	 required init(coder aDecoder: NSCoder) {
	     fatalError("init(coder:) has not been implemented")
	 }
	
}
