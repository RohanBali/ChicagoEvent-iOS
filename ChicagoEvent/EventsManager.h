//
//  EventsManager.h
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-17.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EventsManagerDelegate <NSObject>

- (void)eventsFetchComplete;

@end

@interface EventsManager : NSObject {
    NSDate *_currentFetchedDate;
}

@property (nonatomic,weak) id<EventsManagerDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *eventsDictionary;
@property (nonatomic, strong) NSArray *sortedKeys;

+ (EventsManager *)getSharedInstance;

- (void)getMoreEvents; //TODO: This is only a stub function

@end
