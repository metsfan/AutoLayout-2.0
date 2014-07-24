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
    button.sizeSpec = CGSizeMake(WRAP_CONTENT, WRAP_CONTENT);
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
    AL2RelativeLayoutView *relativeLayout = [[AL2RelativeLayoutView alloc] initWithSize:CGSizeMake(MATCH_PARENT, 250)];
    relativeLayout.backgroundColor = [UIColor greenColor];
    relativeLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view addSubview:relativeLayout];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin_no_logo"]];
    image.sizeSpec = CGSizeMake(10, 10);
    [relativeLayout addSubview:image];
    
    image.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
    [image addGestureRecognizer:imageTap];
    
    UILabel *label = [[UILabel alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
    label.text = @"Hello this is a great label";
    label.backgroundColor = [UIColor redColor];
    label.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [label alignParentRight:YES];
    [relativeLayout addSubview:label];
    
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
    [label addGestureRecognizer:labelTap];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.sizeSpec = CGSizeMake(WRAP_CONTENT, MATCH_PARENT);
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    button.margin = UIEdgeInsetsMake(10, 0, 10, 0);
    button.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    button.backgroundColor = [UIColor grayColor];
    [relativeLayout addSubview:button];
    
    button.userInteractionEnabled = YES;
    UITapGestureRecognizer *buttonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTap:)];
    [button addGestureRecognizer:buttonTap];
    
    
    [button layoutRightOf:image];
    [button layoutBelow:image];
    
    [label layoutRightOf:image];
    [label alignParentBottom:YES];
}

- (void)imageTap:(UIGestureRecognizer *)sender
{
    CGSize spec = sender.view.sizeSpec;
    spec.width += 10;
    spec.height = spec.width;
    if (spec.width > 100 || spec.height > 100)
    {
        spec.width = spec.height = 10;
    }
    
    sender.view.sizeSpec = spec;
}

- (void)buttonTap:(UIGestureRecognizer *)sender
{
    UIEdgeInsets margin = sender.view.margin;
    margin.bottom = rand() % 10;
    margin.left =  rand() % 10;
    margin.right = rand() % 10;
    margin.top = rand() % 10;
    sender.view.margin = margin;
}

- (void)labelTap:(UIGestureRecognizer *)sender
{
    UIEdgeInsets padding = sender.view.padding;
    padding.bottom = rand() % 10;
    padding.left =  rand() % 10;
    padding.right = rand() % 10;
    padding.top = rand() % 10;
    sender.view.padding = padding;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
