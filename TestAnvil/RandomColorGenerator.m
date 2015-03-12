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
    UIColor *color0 = [UIColor colorWithRed:236.0/255.0 green:86.0/255.0 blue:88.0/255.0 alpha:1.0];
    UIColor *color1 = [UIColor colorWithRed:88.0/255.0 green:249.0/255.0 blue:155.0/255.0 alpha:1.0];
    UIColor *color2 = [UIColor colorWithRed:83.0/255.0 green:241.0/255.0 blue:250.0/255.0 alpha:1.0];
    UIColor *color3 = [UIColor colorWithRed:100.0/255.0 green:108.0/255.0 blue:251.0/255.0 alpha:1.0];
    UIColor *color4 = [UIColor colorWithRed:248.0/255.0 green:236.0/255.0 blue:100.0/255.0 alpha:1.0];
    UIColor *color5 = [UIColor colorWithRed:252.0/255.0 green:89.0/255.0 blue:230.0/255.0 alpha:1.0];
    
    NSArray *colors= [[NSArray alloc] initWithObjects:color0,  color1, color2,  color3, color4, color5, nil];
    
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
