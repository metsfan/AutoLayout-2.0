//
//  UILabel+AL2.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "UILabel+AL2.h"

@implementation UILabel (AL2)

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        // Set number of lines to infinite by default, user can override this.
        self.numberOfLines = 0;
    }
    return self;
}

- (void)measure:(CGSize)parentSize
{
    [super measure:parentSize];
    
    CGSize size = self.size;
    
    int textWidth = size.width == WRAP_CONTENT ? parentSize.width : size.width;
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(textWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.font} context:nil];
    
    if (size.width == WRAP_CONTENT) {
        size.width = MIN(textSize.size.width, parentSize.width);
    }
    
    if (size.height == WRAP_CONTENT) {
        size.height = MIN(textSize.size.height, parentSize.height);
    }
    
    self.size = size;
}

@end
