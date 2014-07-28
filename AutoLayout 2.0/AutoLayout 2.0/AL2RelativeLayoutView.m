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
        
        if (layoutParams.alignParentRight && self.sizeSpec.width != WRAP_CONTENT) {
            frame.origin.x = self.size.width - self.padding.right - frame.size.width;
        } else if(layoutParams.align & kAL2AlignmentCenterHorizontal) {
            frame.origin.x = (self.size.width - frame.size.width) * 0.5;
        } else {
            frame.origin.x = padding.left;
        }
        
        if (layoutParams.leftOfView) {
            CGRect leftOfFrame = layoutParams.leftOfView.frame;
            UIEdgeInsets otherMargin = layoutParams.leftOfView.margin;
            if (layoutParams.leftOfView.visibilty == kAL2VisibilityGone) {
                otherMargin = UIEdgeInsetsZero;
            }
            frame.origin.x = leftOfFrame.origin.x - frame.size.width - otherMargin.right;
        } else if (layoutParams.rightOfView) {
            CGRect rightOfFrame = layoutParams.rightOfView.frame;
            UIEdgeInsets otherMargin = layoutParams.rightOfView.margin;
            if (layoutParams.rightOfView.visibilty == kAL2VisibilityGone) {
                otherMargin = UIEdgeInsetsZero;
            }
            frame.origin.x = rightOfFrame.origin.x + rightOfFrame.size.width + otherMargin.left;
        }
    
        if (layoutParams.alignParentBottom && self.sizeSpec.height != WRAP_CONTENT) {
            frame.origin.y = self.size.height - self.padding.bottom - frame.size.height;
        } else if(layoutParams.align & kAL2AlignmentCenterVertical) {
            frame.origin.y = (self.size.height - frame.size.height) * 0.5;
        } else {
            frame.origin.y = padding.top;
        }
        
        if (layoutParams.aboveView) {
            CGRect aboveFrame = layoutParams.aboveView.frame;
            UIEdgeInsets otherMargin = layoutParams.aboveView.margin;
            if (layoutParams.aboveView.visibilty == kAL2VisibilityGone) {
                otherMargin = UIEdgeInsetsZero;
            }
            frame.origin.y = aboveFrame.origin.y - frame.size.height - otherMargin.top;
        } else if (layoutParams.belowView) {
            CGRect belowFrame = layoutParams.belowView.frame;
            UIEdgeInsets otherMargin = layoutParams.belowView.margin;
            if (layoutParams.belowView.visibilty == kAL2VisibilityGone) {
                otherMargin = UIEdgeInsetsZero;
            }
            frame.origin.y = belowFrame.origin.y + belowFrame.size.height + otherMargin.bottom;
        }
        
        frame.origin.x += viewMargin.left;
        frame.origin.y += viewMargin.top;
        
        if (subview.sizeSpec.width == MATCH_PARENT)
            frame.size.width = self.frame.size.width - padding.right - frame.origin.x - viewMargin.right;
        if (subview.sizeSpec.height == MATCH_PARENT)
            frame.size.height = self.frame.size.height - padding.top - frame.origin.y - viewMargin.bottom;

        
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
        } else if(layoutParams.align & kAL2AlignmentCenterHorizontal) {
            frame.origin.x = (self.size.width - self.padding.right - frame.size.width) * 0.5;
        }
        
        if (layoutParams.alignParentBottom) {
            frame.origin.y = self.size.height - self.padding.bottom - frame.size.height;
        } else if(layoutParams.align & kAL2AlignmentCenterVertical) {
            frame.origin.y = (self.size.height - self.padding.bottom - frame.size.height) * 0.5;
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
    
    NSMutableDictionary *depsCount = [[NSMutableDictionary alloc] init];
    
    for (UIView *subview in subviews) {
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
        
        [depsCount setObject:@(deps) forKey:@([subview hash])];
    }
    
    while (subviews.count > 0) {
        NSArray *copy = [subviews copy];
        for (UIView *subview in copy) {
            int deps = [[depsCount objectForKey:@([subview hash])] intValue];
            AL2LayoutParams *params = subview.layoutParams;
            if (params.leftOfView) {
                deps += [[depsCount objectForKey:@([params.leftOfView hash])] intValue];
            }
            
            if (params.rightOfView) {
                deps += [[depsCount objectForKey:@([params.rightOfView hash])] intValue];
            }
            
            if (params.belowView) {
                deps += [[depsCount objectForKey:@([params.belowView hash])] intValue];
            }
            
            if (params.aboveView) {
                deps += [[depsCount objectForKey:@([params.aboveView hash])] intValue];
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
