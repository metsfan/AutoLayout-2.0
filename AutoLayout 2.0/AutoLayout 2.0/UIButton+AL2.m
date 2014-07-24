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
    
    [self.titleLabel measure:self.size];
    
    CGSize size = self.size;
    if (size.width == WRAP_CONTENT) {
        size.width = self.titleLabel.size.width;
    }
    
    if (size.height == WRAP_CONTENT) {
        size.height = self.titleLabel.size.height;
    }
    
    UIEdgeInsets padding = self.padding;
    self.titleEdgeInsets = padding;
    
    self.size = size;
}

@end
