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
    
    //[self testLinearLayout];
    [self testRelativeLayout];
}

- (void)testLinearLayout
{
    AL2LinearLayoutView *linearLayout = [[AL2LinearLayoutView alloc] initWithSize:CGSizeMake(WRAP_CONTENT, WRAP_CONTENT)];
    linearLayout.backgroundColor = [UIColor greenColor];
    linearLayout.orientation = kAL2LinearLayoutVertical;
    linearLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view addSubview:linearLayout];
    
    UILabel *label = [[UILabel alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
    label.text = @"Hello this is a great label";
    label.backgroundColor = [UIColor redColor];
    label.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [linearLayout addSubview:label];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin_no_logo"]];
    [linearLayout addSubview:image];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.size = CGSizeMake(WRAP_CONTENT, WRAP_CONTENT);
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    button.margin = UIEdgeInsetsMake(10, 0, 10, 0);
    button.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    button.backgroundColor = [UIColor grayColor];
    [linearLayout addSubview:button];
    
    UILabel *label2 = [[UILabel alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
    label2.text = @"This is another great label with more text than the other one";
    label2.backgroundColor = [UIColor blueColor];
    label2.margin = UIEdgeInsetsMake(15, 15, 15, 15);
    label2.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [linearLayout addSubview:label2];
}

- (void)testRelativeLayout
{
    AL2RelativeLayoutView *relativeLayout = [[AL2RelativeLayoutView alloc] initWithSize:CGSizeMake(MATCH_PARENT, MATCH_PARENT)];
    relativeLayout.backgroundColor = [UIColor greenColor];
    [self.view addSubview:relativeLayout];
    
    UILabel *label = [[UILabel alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
    label.text = @"Hello this is a great label";
    label.backgroundColor = [UIColor redColor];
    label.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [label alignParentBottom:YES];
    //[label alignParentRight:YES];
    [relativeLayout addSubview:label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
