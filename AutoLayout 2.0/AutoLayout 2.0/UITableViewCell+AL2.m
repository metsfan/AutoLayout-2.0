//
//  UITableViewCell+AL2.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/24/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "UITableViewCell+AL2.h"
#import <objc/runtime.h>

@implementation UITableViewCell (AL2)

static const char *layoutViewKey = "autolayout2.key.tableviewcell.layoutview";

- (AL2LayoutView *)layoutView
{
    return objc_getAssociatedObject(self, layoutViewKey);
}

- (void)setLayoutView:(AL2LayoutView *)layoutView
{
    AL2LayoutView *currentLayoutView = self.layoutView;
    if (currentLayoutView) {
        [currentLayoutView removeFromSuperview];
    }
    
    if (layoutView) {
        [self.contentView addSubview:layoutView];
    }
    
    objc_setAssociatedObject(self, layoutViewKey, layoutView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)size
{
    return self.layoutView.size;
}

@end
