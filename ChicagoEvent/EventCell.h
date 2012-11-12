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
#define kEventCellReuseIdentifier @"EventCellReuseIdentifier"

@interface EventCell : UITableViewCell {
    SliderView *_sliderView;
    TitleView *_titlevView;
    TicketsView *_ticketView;
    UIImageView *_backgroundImageView;
}

@end
