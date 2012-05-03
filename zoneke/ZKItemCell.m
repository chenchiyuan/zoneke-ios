//
//  ZKItemCell.m
//  zoneke
//
//  Created by Shadow on 12-4-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZKItemCell.h"
#import "ZKItemCellText.h"
#import "UIView+UIView_SeeSubviews.h"

@implementation ZKItemCell
@synthesize num;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) loadData{
    ZKItemCellText *image = [[ZKItemCellText alloc] initWithNum:self.num andFrame:CGRectMake(0, 0, 200, 60)];
    
    [self.contentView addSubview: image];
    [image release];
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
