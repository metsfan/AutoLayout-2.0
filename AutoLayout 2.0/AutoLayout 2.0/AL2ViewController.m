//
//  AL2ViewController.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/23/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "AL2ViewController.h"

@interface AL2ViewController ()

@end

@implementation AL2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.edgesForExtendedLayout = UIRectEdgeNone;
    
    AL2LinearLayoutView *linearLayout = [[AL2LinearLayoutView alloc] initWithSize:CGSizeMake(MATCH_PARENT, MATCH_PARENT)];
    [self.view addSubview:linearLayout];
    
    UILabel *label = [[UILabel alloc] initWithSize:CGSizeMake(WRAP_CONTENT, WRAP_CONTENT)];
    label.text = @"Hello this is a great label with a lot more text than we can fit on one line";
    label.numberOfLines = 0;
    [linearLayout addSubview:label];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
