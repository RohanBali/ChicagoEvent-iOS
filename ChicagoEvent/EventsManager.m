//
//  EventsManager.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-17.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "EventsManager.h"
#import "Event.h"

@interface EventsManager()

- (NSString *)getKeyStringForDate;
- (NSArray *)getEventsArray;
- (void)incrementDateByDay;
- (void)sortDictionary;

@end


@implementation EventsManager

@synthesize delegate = _delegate;
@synthesize eventsDictionary = _eventsDictionary;
@synthesize sortedKeys = _sortedKeys;

+ (EventsManager *)getSharedInstance {
    static EventsManager *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        _eventsDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#pragma mark - Public Methods

- (void)getMoreEvents {
    if (!_currentFetchedDate) {
        _currentFetchedDate = [NSDate date];
    }
    NSString *dateKey = [self getKeyStringForDate];
    NSArray *eventsArray = [self getEventsArray];
    [_eventsDictionary setObject:eventsArray forKey:dateKey];
    [self sortDictionary];
    [self incrementDateByDay];
    
    if ([_delegate respondsToSelector:@selector(eventsFetchComplete)]) {
        [_delegate eventsFetchComplete];
    }
}

#pragma mark - Helper Methods

- (NSString *)getKeyStringForDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:_currentFetchedDate];
}

- (void)incrementDateByDay {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:1];
    
    _currentFetchedDate = [[NSCalendar currentCalendar]
                           dateByAddingComponents:dateComponents
                           toDate:_currentFetchedDate options:0];
}

- (void)sortDictionary {
    NSArray *keys = [_eventsDictionary allKeys];

    _sortedKeys = [keys sortedArrayUsingComparator:^(NSString *firstDateString, NSString *secondDateString) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *firstDate = [dateFormatter dateFromString:firstDateString];
        NSDate *secondDate = [dateFormatter dateFromString:secondDateString];
        return [firstDate compare:secondDate];
    }];
}

#pragma mark - Stub Helper Methods

- (NSArray *)getEventsArray {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *eventsArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        [dictionary setObject:[NSString stringWithFormat:@"first : %d",i] forKey:kFirstParameter];
        [dictionary setObject:[NSString stringWithFormat:@"second :%d",i] forKey:kFirstParameter];
        [dictionary setObject:[NSString stringWithFormat:@"third :%d",i] forKey:kFirstParameter];
        Event *event = [[Event alloc] initWithDictionary:dictionary];
        [eventsArray addObject:event];
    }
    return eventsArray;
}

@end
