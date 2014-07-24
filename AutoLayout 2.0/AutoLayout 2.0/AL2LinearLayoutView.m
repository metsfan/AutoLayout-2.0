//
//  AL2LinearLayoutView.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "AL2LinearLayoutView.h"

@implementation AL2LinearLayoutView

- (void)positionSubviews
{
    [super positionSubviews];
    
    NSArray *subviews = self.subviews;
    UIEdgeInsets padding = self.padding;
    
    CGPoint offset = CGPointMake(padding.left, padding.top);
    if (_orientation == kAL2LinearLayoutHorizontal) {
        for (UIView *view in self.subviews) {
            UIEdgeInsets viewMargin = view.margin;
            UIEdgeInsets viewPadding = view.padding;
            
            CGRect frame = view.frame;
            frame.origin = offset;
            frame.origin.x += viewMargin.left;
            frame.origin.y += viewMargin.top;
            frame.size.width += viewPadding.left + viewPadding.right;
            frame.size.height += viewPadding.top + viewPadding.bottom;
            view.frame = frame;
            
            offset.x += frame.origin.x + frame.size.width;
        }
    } else {
        for (UIView *view in self.subviews) {
            UIEdgeInsets viewMargin = view.margin;
            UIEdgeInsets viewPadding = view.padding;
            
            CGRect frame = view.frame;
            frame.origin = offset;
            frame.origin.x += viewMargin.left;
            frame.origin.y += viewMargin.top;
            frame.size.width += viewPadding.left + viewPadding.right;
            frame.size.height += viewPadding.top + viewPadding.bottom;
            view.frame = frame;
            
            offset.y = frame.origin.y + frame.size.height;
        }
    }
}

@end
