//
//  AL2RelativeLayoutView.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "AL2RelativeLayoutView.h"

@interface AL2RelativeLayoutView()

@property (assign, nonatomic) BOOL subviewsDirty;
@property (strong, nonatomic) NSArray *sortedSubviews;

@end

@implementation AL2RelativeLayoutView

- (void)positionSubviews
{
    [super positionSubviews];
    
    if (_subviewsDirty) {
        _subviewsDirty = NO;
        _sortedSubviews = [self sortSubviews];
    }
    
    UIEdgeInsets padding = self.padding;
    
    for (UIView *subview in _sortedSubviews) {
        CGRect frame = subview.frame;
        UIEdgeInsets viewMargin = subview.margin;
        UIEdgeInsets viewPadding = subview.padding;
        AL2LayoutParams *layoutParams = subview.layoutParams;
        
        frame.size.width += viewPadding.left + viewPadding.right;
        frame.size.height += viewPadding.top + viewPadding.bottom;
        
        if (layoutParams.alignParentRight && self.size.width != WRAP_CONTENT) {
            frame.origin.x = self.size.width - self.padding.right - frame.size.width;
        } else if (layoutParams.leftOfView) {
            CGRect leftOfFrame = layoutParams.leftOfView.frame;
            frame.origin.x = leftOfFrame.origin.x - frame.size.width - layoutParams.leftOfView.margin.right;
        } else if (layoutParams.rightOfView) {
            CGRect rightOfFrame = layoutParams.rightOfView.frame;
            frame.origin.x = rightOfFrame.origin.x + rightOfFrame.size.width + layoutParams.rightOfView.margin.left;
        } else {
            frame.origin.x = padding.left;
        }
    
        if (layoutParams.alignParentBottom && self.size.height != WRAP_CONTENT) {
            frame.origin.y = self.size.height - self.padding.bottom - frame.size.height;
        } else if (layoutParams.aboveView) {
            CGRect aboveFrame = layoutParams.aboveView.frame;
            frame.origin.y = aboveFrame.origin.y - frame.size.height - layoutParams.aboveView.margin.top;
        } else if (layoutParams.belowView) {
            CGRect belowFrame = layoutParams.belowView.frame;
            frame.origin.y = belowFrame.origin.y + belowFrame.size.height + layoutParams.belowView.margin.bottom;
        } else {
            frame.origin.y = padding.top;
        }
        
        frame.origin.x += viewMargin.left;
        frame.origin.y += viewMargin.top;
        
        subview.frame = frame;
    }
}

- (void)wrapToSubviews
{
    [super wrapToSubviews];
    
    for (UIView *subview in _sortedSubviews) {
        CGRect frame = subview.frame;
        AL2LayoutParams *layoutParams = subview.layoutParams;
        
        if (layoutParams.alignParentRight) {
            frame.origin.x = self.size.width - self.padding.right - frame.size.width;
        }
        
        if (layoutParams.alignParentBottom) {
            frame.origin.y = self.size.height - self.padding.bottom - frame.size.height;
        }
        
        subview.frame = frame;
    }
}

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    
    _subviewsDirty = YES;
}

- (NSArray *)sortSubviews
{
    NSMutableArray *subviews = [self.subviews mutableCopy];
    
    NSMutableArray *sortedSubviews = [[NSMutableArray alloc] init];
    
    int dependencyMax = 0;
    
    while (subviews.count > 0) {
        NSArray *copy = [subviews copy];
        for (UIView *subview in copy) {
            int deps = 0;
            
            AL2LayoutParams *params = subview.layoutParams;
            if (params.leftOfView) {
                deps++;
            }
            
            if (params.rightOfView) {
                deps++;
            }
            
            if (params.belowView) {
                deps++;
            }
            
            if (params.aboveView) {
                deps++;
            }
            
            if (deps <= dependencyMax) {
                [sortedSubviews addObject:subview];
                [subviews removeObject:subview];
            }
        }
        
        dependencyMax++;
    }
    
    return sortedSubviews;
}

@end
