//
//  RandomColorGenerator.m
//  TestAnvil
//
//  Created by Yi Qin on 3/6/15.
//  Copyright (c) 2015 Yi Qin. All rights reserved.
//

#import "RandomColorGenerator.h"
#import <Colours.h>

@implementation RandomColorGenerator
static int myInt = -1;

+(NSArray *)getColorsArrays {
    UIColor *color0 = [UIColor colorFromHexString:@"eb9a56"];
    UIColor *color1 = [UIColor colorFromHexString:@"f1d2ca"];
    UIColor *color2 = [UIColor colorFromHexString:@"86848c"];
    UIColor *color3 = [UIColor colorFromHexString:@"cee4ee"];
    
    NSArray *colors= [[NSArray alloc] initWithObjects:color0,  color1, color2,  color3, nil];
    
    return colors;
}

+ (UIColor *)getColor {
    NSArray *colorArray = [self getColorsArrays];
    myInt++;
    return [colorArray objectAtIndex:myInt%colorArray.count];
}

+(int) getCurrIndex: (UIColor*) currColor {
    NSArray *colorArray = [self getColorsArrays];
    
    NSUInteger index = [colorArray indexOfObject:currColor];
    
    int currIndex = (int) index;
    
    return currIndex;
}

+(UIColor *)getNextRandomColor:(int) colorIndex{
    NSArray *ranColors = [self getColorsArrays];
    int rand;
    int size = (int)[ranColors count];
    rand =(int) arc4random_uniform(size); // from to size-1
    UIColor *currColor;
    if (rand != colorIndex) {
        currColor = [ranColors objectAtIndex:rand];
    }
    else {
        if (colorIndex == 0) {
            currColor = [ranColors objectAtIndex:rand+1];
        }
        else if (colorIndex == size) {
            rand = (int) arc4random_uniform(size-1);
            currColor = [ranColors objectAtIndex:rand];
        }
        else {
            rand = (int) arc4random_uniform(colorIndex);
            currColor = [ranColors objectAtIndex:rand];
        }
    }
    return currColor;
    
}


@end
