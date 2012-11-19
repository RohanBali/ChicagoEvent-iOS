//
//  Event.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-17.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize firstParameter = _firstParameter;
@synthesize secondParameter = _secondParameter;
@synthesize thirdParameter = _thirdParameter;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _firstParameter = [Event convertObjectNullToNil:[dictionary objectForKey:kFirstParameter]];
        _secondParameter = [Event convertObjectNullToNil:[dictionary objectForKey:kSecondParameter]];
        _thirdParameter = [Event convertObjectNullToNil:[dictionary objectForKey:kThirdParameter]];
    }
    return self;
}

+ (id)convertObjectNullToNil:(id)object {
    if ([object isKindOfClass:[NSNull class]]) {
        return nil;
    } else {
        return object;
    }
}
@end
