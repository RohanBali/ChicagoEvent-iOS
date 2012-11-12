//
//  TitleControl.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-10-30.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

@synthesize containerView = _containerView;

- (id)init {
    UINib *nib = [UINib nibWithNibName:@"TitleView" bundle:nil];
    self = (TitleView *)[[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    if (self) {
        [self setClipsToBounds:YES];
    }
    return self;
}



@end
