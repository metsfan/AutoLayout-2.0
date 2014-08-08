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
    self = [self initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self)
    {
        self.sizeSpec = size;
    }
    
    return self;
}

- (void)measure:(CGSize)parentSize
{
    UIEdgeInsets margin = self.margin;
    UIEdgeInsets padding = self.padding;
    
    CGSize spec = self.sizeSpec;
    CGSize size = self.size;
    
    if (self.visibilty == kAL2VisibilityGone) {
        self.hidden = YES;
        self.frame = CGRectZero;
    } else {
        // If the size is set to a defined value, set it up here
        if (spec.width == MATCH_PARENT) {
            size.width = parentSize.width;
        }
        
        if (spec.height == MATCH_PARENT) {
            size.height = parentSize.height;
        }
        
        CGSize measureSize = size;
        if (spec.width == WRAP_CONTENT) {
            measureSize.width = parentSize.width;
        }
        
        if (spec.height == WRAP_CONTENT) {
            measureSize.height = parentSize.height;
        }
        
        // Measure subviews
        
        self.hidden = self.visibilty == kAL2VisibilityInvisible;
        
        NSArray *subviews = self.subviews;
        for (UIView *view in subviews) {
            if (view.hidden) {
                continue;
            }
            
            CGSize viewMeasureSize = measureSize;
            UIEdgeInsets viewMargin = view.margin;
            UIEdgeInsets viewPadding = view.padding;
            viewMeasureSize.width = viewMeasureSize.width - viewMargin.right - viewMargin.left - padding.left - padding.right - margin.right - margin.left - viewPadding.right - viewPadding.left;
            viewMeasureSize.height = viewMeasureSize.height - viewMargin.bottom - viewMargin.top - padding.top - padding.bottom - margin.bottom - viewPadding.bottom - viewPadding.top;
            [view measure:viewMeasureSize];
        }
        
        self.size = size;
        
    }
}

- (void)wrapToSubviews
{
    CGSize spec = self.sizeSpec;
    CGSize size = self.size;
    NSArray *subviews = self.subviews;
    
    UIEdgeInsets padding = self.padding;
    
    // If the size is wrap content, we can now set the size with our subviews measured
    if (spec.width == WRAP_CONTENT) {
        if (subviews.count == 0) {
            size.width = 0;
        } else {
            int left = INFINITY, right = -INFINITY;
            
            for (UIView *view in subviews) {
                left = MIN(left, view.frame.origin.x);
                right = MAX(right, view.frame.origin.x + view.frame.size.width + view.margin.right);
            }
            
            size.width = (right - left) + padding.right + padding.left;
        }
    }
    
    if (spec.height == WRAP_CONTENT) {
        if (subviews.count == 0) {
            size.height = 0;
        } else {
            int top = INFINITY, bottom = -INFINITY;
            
            for (UIView *view in subviews) {
                top = MIN(top, view.frame.origin.y);
                bottom = MAX(bottom, view.frame.origin.y + view.frame.size.height + view.margin.bottom);
            }
            
            size.height = (bottom - top) + padding.bottom + padding.top;
        }
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
    [self parentNeedsLayout];
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
    [self parentNeedsLayout];
}

- (UIEdgeInsets)padding
{
    NSValue *value = objc_getAssociatedObject(self, paddingKey);
    return [value UIEdgeInsetsValue];
}

- (void)setSizeSpec:(CGSize)spec
{
    AL2LayoutParams *params = self.layoutParams;
    params.spec = spec;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, spec.width, spec.height);
    
    [self parentNeedsLayout];
}

- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGSize)sizeSpec
{
    AL2LayoutParams *params = self.layoutParams;
    return params.spec;
}

- (void)layoutLeftOf:(UIView *)other
{
    AL2LayoutParams *params = self.layoutParams;
    params.leftOfView = other;
    [self parentNeedsLayout];
}

- (void)layoutRightOf:(UIView *)other
{
    AL2LayoutParams *params = self.layoutParams;
    params.rightOfView = other;
    [self parentNeedsLayout];
}

- (void)layoutAbove:(UIView *)other
{
    AL2LayoutParams *params = self.layoutParams;
    params.aboveView = other;
    [self parentNeedsLayout];
}

- (void)layoutBelow:(UIView *)other
{
    AL2LayoutParams *params = self.layoutParams;
    params.belowView = other;
    [self parentNeedsLayout];
}

- (void)alignParentTop:(BOOL)align
{
    AL2LayoutParams *params = self.layoutParams;
    params.alignParentTop = align;
    [self parentNeedsLayout];
}

- (void)alignParentBottom:(BOOL)align
{
    AL2LayoutParams *params = self.layoutParams;
    params.alignParentBottom = align;
    [self parentNeedsLayout];
}

- (void)alignParentRight:(BOOL)align
{
    AL2LayoutParams *params = self.layoutParams;
    params.alignParentRight = align;
    [self parentNeedsLayout];
}

- (void)alignParentLeft:(BOOL)align
{
    AL2LayoutParams *params = self.layoutParams;
    params.alignParentLeft = align;
    [self parentNeedsLayout];
}

- (void)setLayoutParams:(AL2LayoutParams *)layoutParams
{
    objc_setAssociatedObject(self, layoutParamsKey, layoutParams, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self parentNeedsLayout];
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

- (void)setVisibilty:(AL2Visibility)visibilty
{
    AL2LayoutParams *params = self.layoutParams;
    params.visibility = visibilty;
    
    [self parentNeedsLayout];
    
    self.layoutParams = params;
}

- (AL2Visibility)visibilty
{
    return self.layoutParams.visibility;
}

- (void)parentNeedsLayout
{
    if (self.superview)
    {
        [self.superview setNeedsLayout];
    }
}

- (CGSize)measureSize
{
    if (!CGSizeEqualToSize(CGSizeZero, self.layoutParams.measureSize)) {
        CGSize measureSize = self.layoutParams.measureSize;
        measureSize.width = measureSize.width - self.padding.left - self.padding.right;
        
        return measureSize;
    }
    
    if (self.superview != nil) {
        UIView *superview = self.superview;
        return CGSizeMake(superview.size.width - superview.margin.left - superview.margin.right - superview.padding.left - superview.padding.right,
                          superview.size.height - superview.margin.top - superview.margin.bottom - superview.padding.top - superview.padding.bottom);
    }
    
    return self.sizeSpec;
}

- (void)setAlign:(AL2Alignment)align
{
    self.layoutParams.align = align;
}

- (AL2Alignment)align
{
    return self.layoutParams.align;
}

- (void)setAlignSubviews:(AL2Alignment)alignSubviews
{
    self.layoutParams.alignSubviews = alignSubviews;
}

- (AL2Alignment)alignSubviews
{
    return self.layoutParams.alignSubviews;
}

@end
