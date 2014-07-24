//
//  AL2Layout.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "AL2LayoutView.h"

@implementation AL2LayoutView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self measure:self.superview.frame.size];
    
    CGSize size = self.size;
    if (self.size.width == MATCH_PARENT) {
        size.width = self.superview.frame.size.width;
    }
    
    if (self.size.height == MATCH_PARENT) {
        size.width = self.superview.frame.size.height;
    }
    self.size = size;
    
    // Position subviews, this is overriden by derived classes
    [self positionSubviews];
    
    // Apply padding to size
    
    // Wrap content if needed
    if (self.size.width == WRAP_CONTENT || self.size.height == WRAP_CONTENT) {
        [self wrapToSubviews];
    }
}

- (void)positionSubviews
{
}

@end
