//
//  AL2TableViewController.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/24/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "AL2TableViewController.h"
#import "AL2SampleTableViewCell.h"

@interface AL2TableViewController() <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) AL2SampleTableViewCell *prototype;

@end

@implementation AL2TableViewController

static NSString *strings[] = {
    @"This is a string",
    @"This is a slightly longer string",
    @"This string is way too long and shouldn't be this long",
    @"Back to short strings",
    @"This is a string",
    @"This is a slightly longer string",
    @"This string is way too long and shouldn't be this long",
    @"Back to short strings",
    @"This is a string",
    @"This is a slightly longer string",
    @"This string is way too long and shouldn't be this long",
    @"Back to short strings"
};

- (void)viewDidLoad
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[AL2SampleTableViewCell class] forCellReuseIdentifier:@"Sample"];
    _prototype = [[AL2SampleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Sample"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AL2SampleTableViewCell *cell = (AL2SampleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Sample"];

    cell.text = strings[indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _prototype = [[AL2SampleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Sample"];
    _prototype.text = strings[indexPath.row];
    [_prototype layoutIfNeeded];
    
    return _prototype.size.height;
}

@end
