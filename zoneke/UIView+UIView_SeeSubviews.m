//
//  UIView+UIView_SeeSubviews.m
//  zoneke
//
//  Created by tukeQ tukeQ on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIView+UIView_SeeSubviews.h"

@implementation UIView (UIView_SeeSubviews)

- (void) seeSubviews{
    NSArray *subviews = [self subviews];
    
    for (UIView *subview in subviews) {
        NSLog(@"====start====");
        NSLog(@"subview class %@", NSStringFromClass([subview class]));
        NSLog(@"subview frame %f, %f, %f, %f", subview.frame.origin.x, subview.frame.origin.y,
              subview.frame.size.width, subview.frame.size.height);
        NSLog(@"subview %d", subview.tag);
        NSLog(@"=====end=====");
    }
}

@end
