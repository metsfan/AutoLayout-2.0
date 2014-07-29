//
//  UIView+AL2.h
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import <UIKit/UIKit.h>

static const int MATCH_PARENT = 0xFF00;
static const int WRAP_CONTENT = 0xFF01;
static const int CONSTANT_MASK = 0xFF00;

@interface UIView (AL2)

- (instancetype)initWithSize:(CGSize)size;

- (void)measure:(CGSize)parentSize;
- (void)wrapToSubviews;

- (void)setLeftMargin:(int)margin;
- (void)setRightMargin:(int)margin;
- (void)setTopMargin:(int)margin;
- (void)setBottomMargin:(int)margin;

- (void)setLeftPadding:(int)padding;
- (void)setRightPadding:(int)padding;
- (void)setTopPadding:(int)padding;
- (void)setBottomPadding:(int)padding;

/* Relative Layout method */
- (void)layoutLeftOf:(UIView *)other;
- (void)layoutRightOf:(UIView *)other;
- (void)layoutAbove:(UIView *)other;
- (void)layoutBelow:(UIView *)other;
- (void)alignParentTop:(BOOL)align;
- (void)alignParentBottom:(BOOL)align;
- (void)alignParentRight:(BOOL)align;
- (void)alignParentLeft:(BOOL)align;

- (void)parentNeedsLayout;

- (CGSize)measureSize;

@property (assign, nonatomic) CGSize sizeSpec;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) UIEdgeInsets margin;
@property (assign, nonatomic) UIEdgeInsets padding;
@property (strong, nonatomic) AL2LayoutParams *layoutParams;
@property (assign, nonatomic) AL2Visibility visibilty;

@end
