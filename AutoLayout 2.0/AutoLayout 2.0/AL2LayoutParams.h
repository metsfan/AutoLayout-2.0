//
//  AL2LayoutParams.h
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AL2LayoutParams : NSObject

// Original intended size (WRAP_CONTENT, MATCH_PARENT, or pixels)
@property (assign, nonatomic) CGSize spec;
@property (assign, nonatomic) BOOL alignParentTop;
@property (assign, nonatomic) BOOL alignParentBottom;
@property (assign, nonatomic) BOOL alignParentLeft;
@property (assign, nonatomic) BOOL alignParentRight;
@property (strong, nonatomic) UIView *leftOfView;
@property (strong, nonatomic) UIView *rightOfView;
@property (strong, nonatomic) UIView *belowView;
@property (strong, nonatomic) UIView *aboveView;

@end