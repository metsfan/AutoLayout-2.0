//
//  UIImageView+AL2.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "UIImageView+AL2.h"

@implementation UIImageView (AL2)

- (void)measure:(CGSize)parentSize
{
    [super measure:parentSize];
    
    CGSize spec = self.sizeSpec;
    CGSize size = self.size;
    
    if (spec.width == WRAP_CONTENT) {
        size.width = self.image.size.width;
    }
    
    if (spec.height == WRAP_CONTENT) {
        size.height = self.image.size.height;
    }
}

@end
