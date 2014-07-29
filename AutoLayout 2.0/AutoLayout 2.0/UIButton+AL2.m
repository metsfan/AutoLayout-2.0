//
//  UIButton+AL2.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "UIButton+AL2.h"

@implementation UIButton (AL2)

- (void)measure:(CGSize)parentSize
{
    [super measure:parentSize];
    
    //[self.titleLabel measure:self.size];
    
    CGSize spec = self.sizeSpec;
    CGRect frame = self.frame;
    
    if (spec.width == WRAP_CONTENT) {
        frame.size.width = self.titleLabel.frame.size.width;
    }
    
    if (spec.height == WRAP_CONTENT) {
        frame.size.height = self.titleLabel.frame.size.height;
    }
    
    UIEdgeInsets padding = self.padding;
    self.titleEdgeInsets = padding;
    
    self.frame = frame;
}

@end
