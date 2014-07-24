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
static const char *layoutParamsKey = "autolayout2.key.layoutParams";

- (instancetype)initWithSize:(CGSize)size
{
    return [self initWithFrame:CGRectMake(0, 0, size.width, size.height)];
}

- (void)measure:(CGSize)parentSize
{
    UIEdgeInsets margin = self.margin;
    UIEdgeInsets padding = self.padding;
    
    CGSize size = self.size;
    
    // If the size is set to a defined value, set it up here
    if (size.width == MATCH_PARENT) {
        size.width = parentSize.width;
    }
    
    if (size.height == MATCH_PARENT) {
        size.height = parentSize.height;
    }
    
    CGSize measureSize = size;
    if (size.width == WRAP_CONTENT) {
        measureSize.width = parentSize.width;
    }
    
    if (size.height == WRAP_CONTENT) {
        measureSize.height = parentSize.height;
    }
    
    // Measure subviews
    
    NSArray *subviews = self.subviews;
    for (UIView *view in subviews) {
        CGSize viewMeasureSize = measureSize;
        UIEdgeInsets viewMargin = view.margin;
        UIEdgeInsets viewPadding = view.padding;
        viewMeasureSize.width = viewMeasureSize.width - viewMargin.right - viewMargin.left - padding.left - padding.right - margin.right - viewPadding.right - viewPadding.left;
        viewMeasureSize.height = viewMeasureSize.height - viewMargin.bottom - viewMargin.top - padding.top - padding.bottom - margin.bottom - viewPadding.bottom - viewPadding.top;
        [view measure:viewMeasureSize];
    }
    
    self.size = size;
}

- (void)wrapToSubviews
{
    CGSize size = self.size;
    NSArray *subviews = self.subviews;
    
    UIEdgeInsets padding = self.padding;
    
    // If the size is wrap content, we can now set the size with our subviews measured
    if (size.width == WRAP_CONTENT) {
        int left = INFINITY, right = -INFINITY;
        
        for (UIView *view in subviews) {
            left = MIN(left, view.frame.origin.x);
            right = MAX(right, view.frame.origin.x + view.frame.size.width);
        }
        
        size.width = (right - left) + padding.right + padding.left;
    }
    
    if (size.height == WRAP_CONTENT) {
        int top = INFINITY, bottom = -INFINITY;
        
        for (UIView *view in subviews) {
            UIEdgeInsets margin = view.margin;
            
            top = MIN(top, view.frame.origin.y);
            bottom = MAX(bottom, view.frame.origin.y + view.frame.size.height + margin.bottom);
        }
        
        size.height = (bottom - top) + padding.bottom + padding.top;
    }
    
    self.size = size;
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

- (void)layoutLeftOf:(UIView *)other
{
    AL2LayoutParams *params = self.layoutParams;
    params.leftOfView = other;
}

- (void)layoutRightOf:(UIView *)other
{
    AL2LayoutParams *params = self.layoutParams;
    params.rightOfView = other;
}

- (void)layoutAbove:(UIView *)other
{
    AL2LayoutParams *params = self.layoutParams;
    params.aboveView = other;
}

- (void)layoutBelow:(UIView *)other
{
    AL2LayoutParams *params = self.layoutParams;
    params.belowView = other;
}

- (void)alignParentTop:(BOOL)align
{
    AL2LayoutParams *params = self.layoutParams;
    params.alignParentTop = align;
}

- (void)alignParentBottom:(BOOL)align
{
    AL2LayoutParams *params = self.layoutParams;
    params.alignParentBottom = align;
}

- (void)alignParentRight:(BOOL)align
{
    AL2LayoutParams *params = self.layoutParams;
    params.alignParentRight = align;
}

- (void)alignParentLeft:(BOOL)align
{
    AL2LayoutParams *params = self.layoutParams;
    params.alignParentLeft = align;
}

- (void)setLayoutParams:(AL2LayoutParams *)layoutParams
{
    objc_setAssociatedObject(self, layoutParamsKey, layoutParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AL2LayoutParams *)layoutParams
{
    AL2LayoutParams *layoutParams = objc_getAssociatedObject(self, layoutParamsKey);
    if (!layoutParams) {
        layoutParams = [AL2LayoutParams new];
        objc_setAssociatedObject(self, layoutParamsKey, layoutParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return layoutParams;
}

@end
