//
//  Event.h
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-17.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//
//TODO: This is only a stub implementation

#import <Foundation/Foundation.h>

#define kFirstParameter @"first_parameter"
#define kSecondParameter @"second_parameter"
#define kThirdParameter @"third_parameter"

@interface Event : NSObject {
    
}

@property (nonatomic, strong) NSNumber *firstParameter;
@property (nonatomic, strong) NSString *secondParameter;
@property (nonatomic, strong) NSString *thirdParameter;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (id)convertObjectNullToNil:(id)object;


@end
