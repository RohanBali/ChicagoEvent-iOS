//
//  TitleControl.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-10-30.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

- (id)init {
    UINib *nib = [UINib nibWithNibName:@"TitleView" bundle:nil];
    self = (TitleView *)[[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    if (self) {
    
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
