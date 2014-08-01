//
//  UILabel+AL2.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "UILabel+AL2.h"
#import "AutoLayout2.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UILabel (AL2)

static BOOL loaded = NO;

- (instancetype)initWithSize:(CGSize)size
{
    if (!loaded) {
        [UILabel swizzle];
        loaded = YES;
    }
    
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
    
    CGSize spec = self.sizeSpec;
    CGSize size = self.size;
    
    UIEdgeInsets padding = self.padding;
    
    int textWidth = (spec.width == WRAP_CONTENT) ? parentSize.width : size.width;
    textWidth = textWidth - padding.left - padding.right;
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(textWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.font} context:nil];
    
    if (spec.width == WRAP_CONTENT) {
        size.width = floor(MIN(textSize.size.width, parentSize.width));
    }
    
    if (spec.height == WRAP_CONTENT) {
        size.height = floor(textSize.size.height);
    }
    
    //[self sizeToFit];
    self.size = size;
}

- (void)originalDrawTextInRect:(CGRect)rect
{
}

- (void)newDrawTextInRect:(CGRect)rect
{
    UIEdgeInsets padding = self.padding;
    
    rect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(0, padding.left, 0, padding.right));
    [self newDrawTextInRect:rect];
}

- (void)newSetText:(NSString *)text
{
    [self newSetText:text];
    [self parentNeedsLayout];
}

- (void)newSetFont:(UIFont *)font
{
    [self newSetFont:font];
    [self parentNeedsLayout];
}

+ (void)swizzle
{
    Class klass = [UILabel class];
    [AL2Utils swizzleMethod:@selector(drawTextInRect:) in:klass with:@selector(newDrawTextInRect:) in:klass];
    [AL2Utils swizzleMethod:@selector(setText:) in:klass with:@selector(newSetText:) in:klass];
    [AL2Utils swizzleMethod:@selector(setFont:) in:klass with:@selector(newSetFont:) in:klass];
}



@end
