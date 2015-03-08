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
	
	
	//Internal properties
	var rateTitleLabel:UILabel = {  var l = UILabel(frame: CGRectMake(2, 55, 100, 20));
									l.text = "Rate";
									l.textColor = UIColor.whiteColor();
									return l}()
	
	var enableTitleLabel:UILabel = {  var l = UILabel(frame: CGRectMake(2, 5, 250, 20));
		l.text = "Enable Location uploading ";
		l.textColor = UIColor.whiteColor();
		return l}()
	
	var hitsTitleLabel:UILabel = {	var l = UILabel(frame: CGRectMake(112, 55, 140, 20));
									l.text = "Lookups Today" ;
									l.textColor = UIColor.whiteColor();
									return l}();
	
	var earningsTitleLabel:UILabel = {	var l = UILabel(frame: CGRectMake(262, 55, 140, 20));
										l.text = "Total Earnings" ;
										l.textColor = UIColor.whiteColor();
										return l}();

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

	 override  init(frame: CGRect) {
		super.init(frame:frame)
		addSubview(rateTitleLabel)
		addSubview(hitsTitleLabel)
		addSubview(earningsTitleLabel)
		addSubview(enableTitleLabel)
		addSubview(enableLocationSwitch)
		
		rateLabel = UILabel(frame: CGRectMake(2, 95, 100, 20));
		rateLabel.text = "4 cents"
		rateLabel.textColor = UIColor.whiteColor()
		addSubview(rateLabel)
		
		hitsTodayLabel = UILabel(frame: CGRectMake(112, 95, 140, 20));
		hitsTodayLabel.text = "11 hits"
		hitsTodayLabel.textColor = UIColor.whiteColor()

		addSubview(hitsTodayLabel)
	
		totalEarningsLabel = UILabel(frame: CGRectMake(262, 95, 140, 20));
		totalEarningsLabel.text = "352 cents"
		totalEarningsLabel.textColor = UIColor.whiteColor()

		addSubview(totalEarningsLabel)
		
		backgroundColor = UIColor.blackColor()
		
		
	}

	 required init(coder aDecoder: NSCoder) {
	     fatalError("init(coder:) has not been implemented")
	 }
	
}
