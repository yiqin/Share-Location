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
    var enableTitleLabel:UILabel! = nil
    
	var rateLabel:UILabel! = nil
	var hitsTodayLabel:UILabel! = nil
	var totalEarningsLabel:UILabel! = nil
    
    
    var rateTitleLabel:UILabel! = nil
    var hitsTitleLabel:UILabel! = nil
    var earningsTitleLabel:UILabel! = nil
    
    
	var enableLocationSwitch:UISwitch! = nil
	
    private let xPadding : CGFloat = 10
    
    
    
	 override  init(frame: CGRect) {
		super.init(frame:frame)
        
        
        
        
        enableTitleLabel = {  var l = UILabel(frame: CGRectMake(self.xPadding+44, 15, 250, 20));
            l.text = "Enable my location uploading ";
            l.font = UIFont(name: "OpenSans-Semibold", size: 13)
            return l}()
        
        
        enableLocationSwitch = { var l = UISwitch(frame: CGRectMake(285, 10, 100, 50)); return l}()
        
        
        
        let labelWidth = (CGRectGetWidth(frame)-2*xPadding)/3
        
        rateTitleLabel = {  var l = UILabel(frame: CGRectMake(self.xPadding, 55, labelWidth, 20));
            l.text = "Rate";
            l.font = UIFont(name: "OpenSans-Semibold", size: 13)
            l.textAlignment = NSTextAlignment.Center
            return l}()

        
        hitsTitleLabel = {	var l = UILabel(frame: CGRectMake(self.xPadding+labelWidth, 55, labelWidth, 20));
            l.text = "Lookups" ;
            l.font = UIFont(name: "OpenSans-Semibold", size: 13)
            l.textAlignment = NSTextAlignment.Center
            return l}();
        
        earningsTitleLabel = {	var l = UILabel(frame: CGRectMake(self.xPadding+2*labelWidth, 55, labelWidth, 20));
            l.text = "Earnings" ;
            l.font = UIFont(name: "OpenSans-Semibold", size: 13)
            l.textAlignment = NSTextAlignment.Center
            return l}();
        
		addSubview(rateTitleLabel)
		addSubview(hitsTitleLabel)
		addSubview(earningsTitleLabel)
		addSubview(enableTitleLabel)
        
        
		addSubview(enableLocationSwitch)
        enableLocationSwitch.addTarget(self, action: "setStateLocationSwitch:", forControlEvents: UIControlEvents.ValueChanged)
        enableLocationSwitch.setOn(true, animated: true)
        
        
        
        
        let tempRateLabelOffsetY = CGRectGetMaxY(rateTitleLabel.frame)+10
        
        let tempViewWidth : CGFloat = 30
        let tempViewHeigth : CGFloat = 2;
        
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
		rateLabel.text = "$0.90"
        rateLabel.font = UIFont(name: "Lato-Regular", size: 15)
        rateLabel.textAlignment = NSTextAlignment.Center
		addSubview(rateLabel)
		
		hitsTodayLabel = UILabel(frame: CGRectMake(self.xPadding+labelWidth, tempRateLabelOffsetY, labelWidth, 20));
		hitsTodayLabel.text = "9 hits"
        hitsTodayLabel.font = UIFont(name: "Lato-Regular", size: 15)
        hitsTodayLabel.textAlignment = NSTextAlignment.Center
		addSubview(hitsTodayLabel)
	
		totalEarningsLabel = UILabel(frame: CGRectMake(self.xPadding+2*labelWidth, tempRateLabelOffsetY, labelWidth, 20));
		totalEarningsLabel.text = "$13.00"
        totalEarningsLabel.font = UIFont(name: "Lato-Regular", size: 15)
        totalEarningsLabel.textAlignment = NSTextAlignment.Center
		addSubview(totalEarningsLabel)
		
        
        
        
        if enableLocationSwitch.on {
            self.turnBackgroundLight(0.0)
        }
        else {
            self.turnBackgroundDark(0.0)
        }
        
		
	}

	 required init(coder aDecoder: NSCoder) {
	     fatalError("init(coder:) has not been implemented")
	 }
    
    func setStateLocationSwitch(sender:UISwitch) {
        var state = sender.on
        if  state {
            self.turnBackgroundLight(0.80)
        }
        else {
            self.turnBackgroundDark(0.80)
        }
    }
    
    func turnBackgroundLight(duration: NSTimeInterval){
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.backgroundColor = UIColor(fromHexString: "f0f0f0")
            
            let tempColor = UIColor(fromHexString: "4d4d4d")
            
            self.enableTitleLabel.textColor = tempColor
            
            self.rateLabel.textColor = tempColor
            self.hitsTodayLabel.textColor = tempColor
            self.totalEarningsLabel.textColor = tempColor
            
            
            self.rateTitleLabel.textColor = tempColor
            self.hitsTitleLabel.textColor = tempColor
            self.earningsTitleLabel.textColor = tempColor
            
            
            
            
        }) { (completed) -> Void in
            
        }
    }
	
    func turnBackgroundDark(duration: NSTimeInterval){
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.backgroundColor = UIColor(fromHexString: "0f0f0f")
            
            
            let tempColor = UIColor(fromHexString: "f0f0f0")
            
            self.enableTitleLabel.textColor = tempColor
            
            self.rateLabel.textColor = tempColor
            self.hitsTodayLabel.textColor = tempColor
            self.totalEarningsLabel.textColor = tempColor
            
            
            self.rateTitleLabel.textColor = tempColor
            self.hitsTitleLabel.textColor = tempColor
            self.earningsTitleLabel.textColor = tempColor
            
            }) { (completed) -> Void in
                
        }
    }
    
}
