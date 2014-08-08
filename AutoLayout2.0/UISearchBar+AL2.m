//
//  UISearchBar+AL2.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 8/4/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "UISearchBar+AL2.h"
#import "AutoLayout2.h"

@implementation UISearchBar (AL2)

- (void)measure:(CGSize)parentSize
{
    [super measure:parentSize];
    
    CGSize size = self.size;
    CGSize spec = self.sizeSpec;
    
    if (spec.width == WRAP_CONTENT) {
        size.width = parentSize.width;
    }
    
    if (spec.height == WRAP_CONTENT) {
        size.height = 44;
    }
    
    self.size = size;
}

@end
