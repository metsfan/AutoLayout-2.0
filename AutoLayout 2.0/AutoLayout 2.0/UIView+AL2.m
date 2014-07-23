//
//  UIView+AL2.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "UIView+AL2.h"
#import <objc/runtime.h>

@implementation UIView (AL2)

static const char *marginKey = "autolayout2.key.margin";
static const char *paddingKey = "autolayout2.key.padding";

- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, size.width, size.height);
    }
    return self;
}

- (void)measure:(CGRect)parentFrame
{
    UIEdgeInsets margin = self.margin;
    UIEdgeInsets padding = self.padding;
    CGSize size = self.size;
    
    CGRect frame = CGRectMake(parentFrame.origin.x, parentFrame.origin.y, 0, 0);
    
    // If the size is set to a defined value, set it up here
    if (size.width == MATCH_PARENT) {
        frame.size.width = parentFrame.size.width;
    } else {
        frame.size.width = self.frame.size.width;
    }
    
    if (size.height == MATCH_PARENT) {
        frame.size.width = parentFrame.size.width;
    } else {
        frame.size.height = self.frame.size.height;
    }
    
    // Offset frame by left and top margins.
    // Right and bottom margins will be applied by the parent view.
    frame.origin.x += margin.left;
    frame.origin.y += margin.top;
    
    // Measure subviews
    CGRect measureRect = frame;
    
    // Add left and top padding to the measuring rect to offset children
    measureRect.origin.x += padding.left;
    measureRect.origin.y += padding.top;
    
    NSArray *subviews = self.subviews;
    for (UIView *view in subviews) {
        [view measure:measureRect];
    }
    
    // If the size is wrap content, we can now set the size with our subviews measured
    if (size.width == WRAP_CONTENT) {
        int left = INFINITY, right = -INFINITY;
        
        for (UIView *view in subviews) {
            left = MIN(left, view.frame.origin.x);
            right = MAX(right, view.frame.origin.x + view.frame.size.width);
        }
        
        frame.size.width = right - left;
    }
    
    if (size.height == WRAP_CONTENT) {
        int top = INFINITY, bottom = -INFINITY;
        
        for (UIView *view in subviews) {
            top = MIN(top, view.frame.origin.y);
            bottom = MAX(bottom, view.frame.origin.y + view.frame.size.height);
        }
        
        frame.size.height = bottom - top;
    }
    
    // With our size finally defined, apply right and bottom padding
    frame.size.width += padding.right;
    frame.size.height += padding.bottom;
}

- (void)setLeftMargin:(int)margin
{
    UIEdgeInsets margins = self.margin;
    margins.left = margin;
    self.margin = margins;
}

- (void)setRightMargin:(int)margin
{
    UIEdgeInsets margins = self.margin;
    margins.right = margin;
    self.margin = margins;
}

- (void)setTopMargin:(int)margin
{
    UIEdgeInsets margins = self.margin;
    margins.top = margin;
    self.margin = margins;
}

- (void)setBottomMargin:(int)margin
{
    UIEdgeInsets margins = self.margin;
    margins.bottom = margin;
    self.margin = margins;
}

- (void)setMargin:(UIEdgeInsets)margin
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:margin];
    objc_setAssociatedObject(self, marginKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)margin
{
    NSValue *value = objc_getAssociatedObject(self, marginKey);
    return [value UIEdgeInsetsValue];
}

- (void)setLeftPadding:(int)padding
{
    UIEdgeInsets paddings = self.padding;
    paddings.left = padding;
    self.padding = paddings;
}

- (void)setRightPadding:(int)padding
{
    UIEdgeInsets paddings = self.padding;
    paddings.right = padding;
    self.padding = paddings;
}

- (void)setTopPadding:(int)padding
{
    UIEdgeInsets paddings = self.padding;
    paddings.top = padding;
    self.padding = paddings;
}

- (void)setBottomPadding:(int)padding
{
    UIEdgeInsets paddings = self.padding;
    paddings.bottom = padding;
    self.padding = paddings;
}

- (void)setPadding:(UIEdgeInsets)padding
{
    NSValue *value = [NSValue valueWithUIEdgeInsets:padding];
    objc_setAssociatedObject(self, paddingKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)padding
{
    NSValue *value = objc_getAssociatedObject(self, paddingKey);
    return [value UIEdgeInsetsValue];
}

- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (CGSize)size
{
    return self.frame.size;
}

@end
