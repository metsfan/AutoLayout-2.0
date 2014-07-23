//
//  UIView+AL2.h
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import <UIKit/UIKit.h>

static const int MATCH_PARENT = -1;
static const int WRAP_CONTENT = -2;

@interface UIView (AL2)

- (instancetype)initWithSize:(CGSize)size;

- (void)measure:(CGRect)parentFrame;

- (void)setLeftMargin:(int)margin;
- (void)setRightMargin:(int)margin;
- (void)setTopMargin:(int)margin;
- (void)setBottomMargin:(int)margin;

- (void)setLeftPadding:(int)padding;
- (void)setRightPadding:(int)padding;
- (void)setTopPadding:(int)padding;
- (void)setBottomPadding:(int)padding;

@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) UIEdgeInsets margin;
@property (assign, nonatomic) UIEdgeInsets padding;

@end
