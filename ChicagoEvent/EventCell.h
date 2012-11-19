//
//  EventCell.h
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-10-30.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketsView.h"
#import "TitleView.h"
#import "SliderView.h"
#import "SocialView.h"
#import "Event.h"

#define kEventCellReuseIdentifier @"EventCellReuseIdentifier"

@protocol EventCellDelegate <NSObject>

- (void)cellAtIndex:(NSIndexPath *)cellIndex didSlideToIndex:(int)index;

@end

@interface EventCell : UITableViewCell <SliderViewDelegate> {
    SliderView *_sliderView;
    TitleView *_titlevView;
    TicketsView *_ticketView;
    SocialView *_socialView;
    UIImageView *_backgroundImageView;
    Event *_event;
    NSIndexPath *_index;
}

@property (nonatomic, weak) id<EventCellDelegate> delegate;

- (void)configureWithIndex:(NSIndexPath *)cellIndex andEvent:(Event *)event;
- (void)resetSliderAtIndex:(int)index;

@end
