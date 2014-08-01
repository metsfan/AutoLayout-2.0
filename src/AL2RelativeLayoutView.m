//
//  AL2RelativeLayoutView.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "AL2RelativeLayoutView.h"
#import "AutoLayout2.h"

@interface AL2RelativeLayoutView()

@property (assign, nonatomic) BOOL subviewsDirty;
@property (strong, nonatomic) NSArray *sortedSubviews;

@end

@implementation AL2RelativeLayoutView

- (void)positionSubviews
{
    [super positionSubviews];
    
    if (_subviewsDirty) {
        _subviewsDirty = NO;
        _sortedSubviews = [self sortSubviews];
    }
    
    UIEdgeInsets padding = self.padding;
    
    for (UIView *subview in _sortedSubviews) {
        CGRect frame = subview.frame;
        UIEdgeInsets viewMargin = subview.margin;
        UIEdgeInsets viewPadding = subview.padding;
        AL2LayoutParams *layoutParams = subview.layoutParams;
        UIEdgeInsets measureBounds = UIEdgeInsetsMake(frame.origin.y, frame.origin.x, frame.origin.y + frame.size.height, frame.origin.x + frame.size.width);
        
        frame.size.width += viewPadding.left + viewPadding.right;
        frame.size.height += viewPadding.top + viewPadding.bottom;
        
        if (layoutParams.alignParentRight && self.sizeSpec.width != WRAP_CONTENT) {
            measureBounds.right = self.size.width - padding.right - viewMargin.right;
            measureBounds.left = measureBounds.right - frame.size.width;
        } else if(layoutParams.align & kAL2AlignmentCenterHorizontal) {
            measureBounds.left = (self.size.width - frame.size.width) * 0.5;
            measureBounds.right = measureBounds.left + frame.size.width;
        }
        
        if (layoutParams.leftOfView) {
            measureBounds.right = layoutParams.leftOfView.layoutParams.measureBounds.left;
            
            if (!layoutParams.rightOfView && !layoutParams.alignParentRight) {
                measureBounds.left = measureBounds.right - frame.size.width;
            }
        }
        
        if (layoutParams.rightOfView) {
            measureBounds.left = layoutParams.rightOfView.layoutParams.measureBounds.right;
            
            if (!layoutParams.rightOfView && !layoutParams.alignParentRight) {
                measureBounds.right = measureBounds.left + frame.size.width;
            }
        }
        
        int offset = viewMargin.left + padding.left;
        measureBounds.left += offset;
        measureBounds.right += offset;
    
        if (layoutParams.alignParentBottom && self.sizeSpec.height != WRAP_CONTENT) {
            measureBounds.bottom = self.size.height - padding.bottom - viewMargin.bottom;
            measureBounds.top = measureBounds.bottom - frame.size.height;
        } else if(layoutParams.align & kAL2AlignmentCenterVertical) {
            measureBounds.top = (self.size.height - frame.size.height) * 0.5;
            measureBounds.bottom = measureBounds.top + frame.size.height;
        }
        
        if (layoutParams.aboveView) {
            measureBounds.bottom = layoutParams.aboveView.layoutParams.measureBounds.top;
            
            if (!layoutParams.belowView && !layoutParams.alignParentBottom) {
                measureBounds.top = measureBounds.bottom - frame.size.height;
            }
        }
        
        if (layoutParams.belowView) {
            measureBounds.top = layoutParams.belowView.layoutParams.measureBounds.bottom;

            if (!layoutParams.aboveView && !layoutParams.alignParentTop) {
                measureBounds.bottom = measureBounds.top + frame.size.height;
            }
        }
        
        offset = viewMargin.top + padding.top;
        measureBounds.top += offset;
        measureBounds.bottom += offset;
        
        //frame.origin.y += viewMargin.top;
        
        if (subview.sizeSpec.width == MATCH_PARENT)
            measureBounds.right = self.frame.size.width - padding.right;
            //frame.size.width = self.frame.size.width - padding.right - frame.origin.x - viewMargin.right;
            
        if (subview.sizeSpec.height == MATCH_PARENT)
            measureBounds.bottom = self.frame.size.height - padding.bottom;
            //frame.size.height = self.frame.size.height - padding.top - frame.origin.y - viewMargin.bottom;

        //measureBounds.right -= viewMargin.right;
        
        CGSize oldSize = frame.size;
        
        frame.origin.x = measureBounds.left;
        frame.origin.y = measureBounds.top;
        frame.size.width = measureBounds.right - measureBounds.left;
        frame.size.height = measureBounds.bottom - measureBounds.top;

        subview.frame = frame;
        
        if (!CGSizeEqualToSize(oldSize, frame.size)) {
            // If our size has changed, re-measure constrained to new size
            [subview measure:frame.size];
        }
        
        
        subview.layoutParams.measureBounds = measureBounds;
        
        
    }
}

- (void)wrapToSubviews
{
    [super wrapToSubviews];
    
    for (UIView *subview in _sortedSubviews) {
        CGRect frame = subview.frame;
        AL2LayoutParams *layoutParams = subview.layoutParams;
        
        if (layoutParams.alignParentRight) {
            frame.origin.x = self.size.width - self.padding.right - frame.size.width;
        } else if(layoutParams.align & kAL2AlignmentCenterHorizontal) {
            frame.origin.x = (self.size.width - self.padding.right - frame.size.width) * 0.5;
        }
        
        if (layoutParams.alignParentBottom) {
            frame.origin.y = self.size.height - self.padding.bottom - frame.size.height;
        } else if(layoutParams.align & kAL2AlignmentCenterVertical) {
            frame.origin.y = (self.size.height - self.padding.bottom - frame.size.height) * 0.5;
        }
        
        subview.frame = frame;
    }
}

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    
    _subviewsDirty = YES;
}

- (NSArray *)sortSubviews
{
    NSMutableArray *subviews = [self.subviews mutableCopy];
    
    NSMutableArray *sortedSubviews = [[NSMutableArray alloc] init];
    
    int dependencyMax = 0;
    
    NSMutableDictionary *depsCount = [[NSMutableDictionary alloc] init];
    
    for (UIView *subview in subviews) {
        int deps = 0;
        
        AL2LayoutParams *params = subview.layoutParams;
        if (params.leftOfView) {
            deps++;
        }
        
        if (params.rightOfView) {
            deps++;
        }
        
        if (params.belowView) {
            deps++;
        }
        
        if (params.aboveView) {
            deps++;
        }
        
        [depsCount setObject:@(deps) forKey:@([subview hash])];
    }
    
    while (subviews.count > 0) {
        NSArray *copy = [subviews copy];
        for (UIView *subview in copy) {
            int deps = [[depsCount objectForKey:@([subview hash])] intValue];
            AL2LayoutParams *params = subview.layoutParams;
            if (params.leftOfView) {
                deps += [[depsCount objectForKey:@([params.leftOfView hash])] intValue];
            }
            
            if (params.rightOfView) {
                deps += [[depsCount objectForKey:@([params.rightOfView hash])] intValue];
            }
            
            if (params.belowView) {
                deps += [[depsCount objectForKey:@([params.belowView hash])] intValue];
            }
            
            if (params.aboveView) {
                deps += [[depsCount objectForKey:@([params.aboveView hash])] intValue];
            }
            
            if (deps <= dependencyMax) {
                [sortedSubviews addObject:subview];
                [subviews removeObject:subview];
            }
        }
        
        dependencyMax++;
    }
    
    return sortedSubviews;
}

@end
