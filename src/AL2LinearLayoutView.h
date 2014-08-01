//
//  AL2LinearLayoutView.h
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AL2LayoutView.h"

typedef enum {
    kAL2LinearLayoutVertical,
    kAL2LinearLayoutHorizontal
} AL2LinearLayoutOrientation;

@interface AL2LinearLayoutView : AL2LayoutView

@property (assign, nonatomic) AL2LinearLayoutOrientation orientation;

@end
