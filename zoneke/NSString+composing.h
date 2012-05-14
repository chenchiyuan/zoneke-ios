//
//  NSString+composing.h
//  zoneke
//
//  Created by  on 12-5-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MAX_LINE_WIDTH 180
#define MIN_DIALOG_HEIGHT 60

typedef struct{
    float width;
    float height;
    int lines;
}Composing; 

@interface NSString (composing)

-(Composing *) composing;

@end
