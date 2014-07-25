//
//  AL2SampleTableViewCell.m
//  AutoLayout 2.0
//
//  Created by Adam Eskreis on 7/24/14.
//  Copyright (c) 2014 Adam Eskreis. All rights reserved.
//

#import "AL2SampleTableViewCell.h"

@interface AL2SampleTableViewCell()

@property (strong, nonatomic) UILabel *label;

@end

@implementation AL2SampleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.layoutView = [[AL2LinearLayoutView alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
        self.layoutView.backgroundColor = [UIColor greenColor];
        
        _label = [[UILabel alloc] initWithSize:CGSizeMake(MATCH_PARENT, WRAP_CONTENT)];
        _label.text = @"Welcome to my table";
        _label.font = [UIFont systemFontOfSize:50];
        //_label.backgroundColor = [UIColor redColor];
        [self.layoutView addSubview:_label];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setText:(NSString *)text
{
    _label.text = text;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
