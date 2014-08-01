//
//  AL2LinearLayoutView.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "AL2LinearLayoutView.h"
#import "AutoLayout2.h"

@implementation AL2LinearLayoutView

- (void)positionSubviews
{
    [super positionSubviews];
    
    NSArray *subviews = self.subviews;
    UIEdgeInsets padding = self.padding;
    UIEdgeInsets margin = self.margin;
    
    AL2Alignment defaultAlign = self.layoutParams.alignSubviews;
    
    CGPoint offset = CGPointMake(padding.left, padding.top);
    
    for (UIView *view in self.subviews) {
        if (view.hidden) {
            continue;
        }
        
        UIEdgeInsets viewMargin = view.margin;
        UIEdgeInsets viewPadding = view.padding;
        CGPoint viewOffset = offset;

        AL2Alignment align = view.layoutParams.align;
        if (align == kAL2AlignmentInherit) {
            align = defaultAlign;
        }
        
        CGRect frame = view.frame;
        UIEdgeInsets measureBounds = UIEdgeInsetsMake(frame.origin.y, frame.origin.x, frame.origin.y + frame.size.height, frame.origin.x + frame.size.width);

        measureBounds.left = viewOffset.x + viewMargin.left;
        measureBounds.right = measureBounds.left + frame.size.width + viewPadding.right + viewPadding.left;
        measureBounds.top = viewOffset.y + viewMargin.top;
        measureBounds.bottom = measureBounds.top + frame.size.height + viewPadding.top + viewPadding.bottom;
        
        view.frame = CGRectMake(measureBounds.left, measureBounds.top, measureBounds.right - measureBounds.left, measureBounds.bottom - measureBounds.top);
        view.layoutParams.measureBounds = measureBounds;
        
        if (_orientation == kAL2LinearLayoutHorizontal) {
            offset.x = measureBounds.right + viewMargin.right;
        } else {
            offset.y = measureBounds.bottom + viewMargin.bottom;
        }
    }
}

- (void)postLayout
{
    [super postLayout];
    
    if (self.hidden) {
        return;
    }
    
    AL2Alignment defaultAlign = self.layoutParams.alignSubviews;
    
    if (_orientation == kAL2LinearLayoutHorizontal) {
        int rightOffset = [self measureSize].width;

        int left = INFINITY, right = -INFINITY;
        for (UIView *view in self.subviews) {
            left = MIN(left, view.frame.origin.x);
            right = MAX(right, view.frame.size.width + view.frame.origin.x);
        }
        
        int wrappedWidth = right - left;
        int wrappedOffset = (rightOffset - wrappedWidth) * 0.5;
        
        for (NSInteger i = self.subviews.count - 1; i >= 0; i--) {
            UIView *view = self.subviews[i];
            
            AL2Alignment align = view.layoutParams.align;
            if (align == kAL2AlignmentInherit) {
                align = defaultAlign;
            }
            CGRect frame = view.frame;

            // We only need to make adjustments for right and center, since left is default
            if (align & kAL2AlignmentBottom) {
                frame.origin.y = self.size.height - frame.origin.y - frame.size.height;
            } else if (align & kAL2AlignmentCenterVertical) {
                frame.origin.y = (self.size.height - frame.origin.y - frame.size.height) * 0.5;
            }
            
            // We only need to make adjustments for bottom and center, since top is default
            if (align & kAL2AlignmentRight) {
                frame.origin.x = rightOffset - frame.size.width;
            } else if (align & kAL2AlignmentCenterHorizontal) {
                frame.origin.x += wrappedOffset;
            }
            
            rightOffset -= frame.size.width;
            
            view.frame = frame;
        }
    } else {
        int bottomOffset = [self measureSize].height;
        int wrappedHeight = 0;
        for (UIView *view in self.subviews) {
            wrappedHeight += view.frame.size.height;
        }
        
        int wrappedOffset = (bottomOffset - wrappedHeight) * 0.5;
        
        for (NSInteger i = self.subviews.count - 1; i >= 0; i--) {
            UIView *view = self.subviews[i];
            
            AL2Alignment align = view.layoutParams.align;
            if (align == kAL2AlignmentInherit) {
                align = defaultAlign;
            }
            CGRect frame = view.frame;
            
            
            // We only need to make adjustments for right and center, since left is default
            if (align & kAL2AlignmentRight) {
                frame.origin.x = self.size.width - frame.origin.x - frame.size.width;
            } else if (align & kAL2AlignmentCenterHorizontal) {
                frame.origin.x = (self.size.width - frame.origin.x - frame.size.width) * 0.5;
            }
            
            // We only need to make adjustments for bottom and center, since top is default
            if (align & kAL2AlignmentBottom) {
                frame.origin.y = bottomOffset - frame.size.height;
            } else if (align & kAL2AlignmentCenterVertical) {
                frame.origin.y += wrappedOffset;
            }
            
            bottomOffset -= frame.size.height;
            view.frame = frame;
        }
    }
}

@end
