//
//  SocialView.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-16.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "SocialView.h"

@implementation SocialView

- (id)init {
    UINib *nib = [UINib nibWithNibName:@"SocialView" bundle:nil];
    self = (SocialView *)[[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    if (self) {
        [self setClipsToBounds:YES];
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
