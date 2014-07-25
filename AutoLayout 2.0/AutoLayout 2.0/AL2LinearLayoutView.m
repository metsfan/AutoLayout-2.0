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
    UIEdgeInsets margin = self.margin;
    
    AL2Alignment defaultAlign = self.layoutParams.alignSubviews;
    
    CGPoint offset = CGPointMake(padding.left, padding.top);
    if (_orientation == kAL2LinearLayoutHorizontal) {
        for (UIView *view in self.subviews) {
            UIEdgeInsets viewMargin = view.margin;
            UIEdgeInsets viewPadding = view.padding;
            AL2Alignment align = view.layoutParams.align;
            if (align == kAL2AlignmentInherit) {
                align = defaultAlign;
            }
            
            CGRect frame = view.frame;
            frame.origin = offset;
            frame.origin.x += viewMargin.left;
            frame.origin.y += viewMargin.top;
            frame.size.width += viewPadding.left + viewPadding.right;
            frame.size.height += viewPadding.top + viewPadding.bottom;
            view.frame = frame;
            
            if (self.sizeSpec.width != WRAP_CONTENT && (self.frame.size.width - (frame.size.width + offset.x)) < 0) {
                //frame.size.width = self.frame.size.width - margin.right - viewMargin.right - offset.x - 100;
                CGSize measureSize = CGSizeMake(100, 20);
                [view measure:measureSize];
            }
            
            offset.x += frame.origin.x + frame.size.width;
            
            
        }
    } else {
        for (UIView *view in self.subviews) {
            UIEdgeInsets viewMargin = view.margin;
            UIEdgeInsets viewPadding = view.padding;
            CGPoint viewOffset = offset;
            
            AL2Alignment align = view.layoutParams.align;
            if (align == kAL2AlignmentInherit) {
                align = defaultAlign;
            }
            
            /*if (self.sizeSpec.width != WRAP_CONTENT) {
                // We only need to make adjustments for right and center, since left is default
                if (align & kAL2AlignmentRight) {
                    viewOffset +=
                } else if (align & kAL2AlignmentCenterHorizontal) {
                    
                }
            }*/
            
            CGRect frame = view.frame;
            frame.origin = viewOffset;
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
