//
//  ZKDialogCell.h
//  zoneke
//
//  Created by  on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@interface ZKDialogCell : UITableViewCell

@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIImageView *dialog;

- (void) loadData:(int) origin content: (NSString *) content;

@end
