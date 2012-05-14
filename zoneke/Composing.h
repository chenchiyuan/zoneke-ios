//
//  Composing.h
//  zoneke
//
//  Created by  on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Composing : NSObject

@property (nonatomic, assign) float height;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) int lines;

- (id)initWithLines:(int) lines height:(float) height width:(float) width;
- (id)initWithString:(NSString *) content;

@end
