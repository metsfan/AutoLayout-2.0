//
//  AL2Layout.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "AL2LayoutView.h"
#import "AutoLayout2.h"

@implementation AL2LayoutView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self measure:[self.superview measureSize]];
}

- (void)layoutSubviewsInternal
{
    // Position subviews, this is overriden by derived classes
    [self positionSubviews];
    
    // Apply padding to size
    
    // Wrap content if needed
    if (self.sizeSpec.width == WRAP_CONTENT || self.sizeSpec.height == WRAP_CONTENT) {
        [self wrapToSubviews];
    }
    
    [self postLayout];
}

- (void)measure:(CGSize)parentSize
{
    [super measure:parentSize];
    
    [self layoutSubviewsInternal];
}

- (void)positionSubviews
{
}

- (void)postLayout
{
    
}

@end
