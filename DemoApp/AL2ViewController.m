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
    
    [self testLinearLayout];
    //[self testLinearLayoutAlignment];
    //[self testRelativeLayout];
    //[self testRelativeLayout2];
}

- (void)testRelativeLayout3
{
    AL2RelativeLayoutView *mainLayout = [[AL2RelativeLayoutView alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
    mainLayout.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:mainLayout];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stream-button"]];
    //image.visibilty = kAL2VisibilityGone;
    [mainLayout addSubview:image];
    
    UILabel *label = [[UILabel alloc] initWithSize:CGSizeMake(WRAP_CONTENT, WRAP_CONTENT)];
    label.text = @"this is some text really long text that should wrap";
    [label layoutRightOf:image];
    [mainLayout addSubview:label];
    
    UIImageView *image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stream-button"]];
    [image2 alignParentRight:YES];
    //image2.visibilty = kAL2VisibilityGone;
    [mainLayout addSubview:image2];
    
    [label layoutLeftOf:image2];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(containerTap:)];
    [mainLayout addGestureRecognizer:tap];
}

- (void)testRelativeLayout2
{
    AL2RelativeLayoutView *mainLayout = [[AL2RelativeLayoutView alloc] initWithSize:CGSizeMake(MATCH_PARENT, MATCH_PARENT)];
    mainLayout.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:mainLayout];
    
    // Stream button
    UIButton *stream = [UIButton buttonWithType:UIButtonTypeCustom];
    stream.sizeSpec = CGSizeMake(WRAP_CONTENT, WRAP_CONTENT);
    [stream setBackgroundImage:[UIImage imageNamed:@"stream-button"] forState:UIControlStateNormal];
    
    [stream alignParentLeft:YES];
    [stream alignParentTop:YES];
    stream.margin = UIEdgeInsetsMake(15, 10, 0, 0);
    
    [mainLayout addSubview:stream];
    
    // Search button
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.sizeSpec = CGSizeMake(WRAP_CONTENT, WRAP_CONTENT);
    [search setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    
    [search alignParentRight:YES];
    [search alignParentTop:YES];
    search.margin = UIEdgeInsetsMake(15, 0, 0, 10);
    
    [mainLayout addSubview:search];
    
    // Center logo
    UIImageView *citymaps = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sky-logo"]];
    
    citymaps.align = kAL2AlignmentCenterHorizontal;
    [citymaps setTopMargin:10];
    
    [mainLayout addSubview:citymaps];
    
    // Compass
    UIImageView *compass = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass-container"]];
    
    [compass alignParentRight:YES];
    [compass layoutBelow:search];
    compass.margin = UIEdgeInsetsMake(5, 0, 0, 10);
    
    [mainLayout addSubview:compass];
    
    // Compass needle
    UIImageView *compassNeedle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compass-needle"]];
    [compass addSubview:compassNeedle];
    
    // Find me container
    AL2LinearLayoutView *gpsView = [[AL2LinearLayoutView alloc] initWithSize:CGSizeMake(WRAP_CONTENT, WRAP_CONTENT)];
    gpsView.orientation = kAL2LinearLayoutHorizontal;
    gpsView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"find_me_base"]];
    
    [gpsView alignParentRight:YES];
    [gpsView alignParentBottom:YES];
    gpsView.margin = UIEdgeInsetsMake(0, 0, 10, 10);
    
    [mainLayout addSubview:gpsView];
    
    // Pins button
    UIButton *pinsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pinsButton.sizeSpec = CGSizeMake(WRAP_CONTENT, WRAP_CONTENT);
    [pinsButton setBackgroundImage:[UIImage imageNamed:@"find_me_pins_on"] forState:UIControlStateNormal];
    [gpsView addSubview:pinsButton];
    
    // Find me button
    UIButton *findMeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    findMeButton.sizeSpec = CGSizeMake(WRAP_CONTENT, WRAP_CONTENT);
    [findMeButton setBackgroundImage:[UIImage imageNamed:@"find_me_default"] forState:UIControlStateNormal];
    [gpsView addSubview:findMeButton];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(containerTap:)];
//    [mainLayout addGestureRecognizer:tap];
}

- (void)testLinearLayout
{
    
    AL2LinearLayoutView *linearLayout = [[AL2LinearLayoutView alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
    linearLayout.backgroundColor = [UIColor greenColor];
    linearLayout.orientation = kAL2LinearLayoutVertical;
    linearLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    //linearLayout.layoutParams.alignSubviews = kAL2AlignmentCenterVertical;
    [self.view addSubview:linearLayout];
    
    UILabel *label = [[UILabel alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
    label.text = @"Hello this is a great label";
    label.backgroundColor = [UIColor redColor];
    label.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [linearLayout addSubview:label];
    
    
    //label.visibilty = kAL2VisibilityGone;
    
    AL2LinearLayoutView *linearLayout2 = [[AL2LinearLayoutView alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
    linearLayout2.backgroundColor = [UIColor greenColor];
    linearLayout2.orientation = kAL2LinearLayoutHorizontal;
    linearLayout2.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    linearLayout2.layoutParams.alignSubviews = kAL2AlignmentCenterHorizontal;
    linearLayout2.backgroundColor = [UIColor yellowColor];
    [linearLayout addSubview:linearLayout2];
    linearLayout2.visibilty = kAL2VisibilityGone;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.sizeSpec = CGSizeMake(WRAP_CONTENT, WRAP_CONTENT);
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    //button.margin = UIEdgeInsetsMake(10, 0, 10, 0);
    //button.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    button.backgroundColor = [UIColor grayColor];
    [linearLayout2 addSubview:button];
    
    
    UILabel *label2 = [[UILabel alloc] initWithSize:CGSizeMake(WRAP_CONTENT, WRAP_CONTENT)];
    label2.text = @"hi";
    label2.backgroundColor = [UIColor blueColor];
    //label2.margin = UIEdgeInsetsMake(15, 15, 15, 15);
    //label2.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [linearLayout2 addSubview:label2];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin_no_logo"]];
    [linearLayout addSubview:image];
}

- (void)testLinearLayoutAlignment
{
    
    AL2LinearLayoutView *linearLayout = [[AL2LinearLayoutView alloc] initWithSize:CGSizeMake(MATCH_PARENT, MATCH_PARENT)];
    linearLayout.backgroundColor = [UIColor greenColor];
    linearLayout.orientation = kAL2LinearLayoutHorizontal;
    //linearLayout.orientation = kAL2LinearLayoutHorizontal;
    //linearLayout.layoutParams.alignSubviews = kAL2AlignmentBottom | kAL2AlignmentCenterHorizontal;
    linearLayout.layoutParams.alignSubviews = kAL2AlignmentTop | kAL2AlignmentCenterHorizontal;
    [self.view addSubview:linearLayout];
    
    UILabel *label = [[UILabel alloc] initWithSize:CGSizeMake(WRAP_CONTENT, WRAP_CONTENT)];
    label.text = @"Sample Text 1";
    //label.layoutParams.align = kAL2AlignmentCenter;
    [linearLayout addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] initWithSize:CGSizeMake(WRAP_CONTENT, WRAP_CONTENT)];
    label2.text = @"Sample Text 2";
    [linearLayout addSubview:label2];
}


- (void)testRelativeLayout
{
    AL2RelativeLayoutView *relativeLayout = [[AL2RelativeLayoutView alloc] initWithSize:CGSizeMake(MATCH_PARENT, 250)];
    relativeLayout.backgroundColor = [UIColor greenColor];
    relativeLayout.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.view addSubview:relativeLayout];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pin_no_logo"]];
    image.sizeSpec = CGSizeMake(280, 200);
    image.layoutParams.align = kAL2AlignmentCenter;
    [relativeLayout addSubview:image];
    
    image.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
    [image addGestureRecognizer:imageTap];
    
    UILabel *label = [[UILabel alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
    label.text = @"Hello this is a great label";
    label.backgroundColor = [UIColor redColor];
    label.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    //[label alignParentRight:YES];
    //[relativeLayout addSubview:label];
    
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
    [label addGestureRecognizer:labelTap];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.sizeSpec = CGSizeMake(WRAP_CONTENT, WRAP_CONTENT);
    [button setTitle:@"Press me" forState:UIControlStateNormal];
    button.margin = UIEdgeInsetsMake(10, 0, 10, 0);
    button.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    button.backgroundColor = [UIColor grayColor];
    //button.visibilty = kAL2VisibilityGone;
    //[relativeLayout addSubview:button];
    
    button.userInteractionEnabled = YES;
    UITapGestureRecognizer *buttonTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTap:)];
    [button addGestureRecognizer:buttonTap];
    
    
    [button layoutRightOf:image];
    [button layoutBelow:image];
    
    [label layoutRightOf:button];
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

- (void)containerTap:(UIGestureRecognizer *)tap
{
    AL2RelativeLayoutView *view = (AL2RelativeLayoutView *)tap.view;
    view.sizeSpec = CGSizeMake(view.size.width - 10, WRAP_CONTENT);
}

@end
