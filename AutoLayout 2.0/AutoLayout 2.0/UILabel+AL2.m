//
//  UILabel+AL2.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "UILabel+AL2.h"
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
        
        //IMP oldDrawImp = method_getImplementation(oldDraw);
        
        //class_replaceMethod([UILabel class], @selector(drawTextInRect:), method_getImplementation(newDraw), method_getTypeEncoding(newDraw));
        //class_replaceMethod([UILabel class], @selector(originlDrawTextInRect:), method_getImplementation(oldDraw), method_getTypeEncoding(oldDraw));
        //method_exchangeImplementations(oldDraw, holder);
        //method_setImplementation(oldDraw, method_getImplementation(holder));
    }
    return self;
}

- (void)measure:(CGSize)parentSize
{
    [super measure:parentSize];
    
    CGSize size = self.size;
    
    UIEdgeInsets padding = self.padding;
    
    int textWidth = size.width == WRAP_CONTENT ? parentSize.width : size.width;
    textWidth = textWidth - padding.left - padding.right;
    CGRect textSize = [self.text boundingRectWithSize:CGSizeMake(textWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.font} context:nil];
    
    if (size.width == WRAP_CONTENT) {
        size.width = MIN(textSize.size.width, parentSize.width);
    }
    
    if (size.height == WRAP_CONTENT) {
        size.height = MIN(textSize.size.height, parentSize.height);
    }
    
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

/*- (void)drawTextInRect:(CGRect)rect
{
    rect = UIEdgeInsetsInsetRect(rect, self.padding);
    //[self originalDrawTextInRect:rect];
    objc_msgSend(self, @selector(originalDrawTextInRect:), rect);
}*/

+ (void)swizzle
{
    Class klass = [UILabel class];
    [AL2Utils swizzleMethod:@selector(drawTextInRect:) in:klass with:@selector(newDrawTextInRect:) in:klass];
}

@end
