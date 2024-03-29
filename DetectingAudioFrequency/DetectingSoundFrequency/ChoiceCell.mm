//
//  ChoiceCell.m
//  DetectingSoundFrequency
//
//  Created by Anubhaw Arya on 8/1/14.
//  Copyright (c) 2014 Mac. All rights reserved.
//

#import "ChoiceCell.h"

@implementation ChoiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.btn setFrame:self.frame];
        [self.btn setBackgroundColor:[UIColor colorWithRed:236/255.0f green:240/255.0f blue:241/255.0f alpha:1.0f]];
        [self.btn.titleLabel setAdjustsFontSizeToFitWidth:YES];
        [self.btn setTitleColor:AppConstants.blackFont forState:UIControlStateNormal];
        [self addSubview:self.btn];
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

@end
