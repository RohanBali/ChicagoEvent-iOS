//
//  SliderView.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-11.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "SliderView.h"

@interface SliderView()

- (void)setupSliderButton;
- (void)updateSliderArrayWithView:(UIView *)view;
- (void)updateSubviewAllignmentWithView:(UIView *)view;

@end

@implementation SliderView

- (id)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0f, 0.0f , 240.0f , self.frame.size.height);
        _circularArray = [[NSMutableArray alloc] init];
        [self setupSliderButton];
    }
    return self;
}

#pragma mark - Setup Methods

- (void)setupSliderButton {
    _sliderButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20.0f, 0.0f, 20.0f, self.frame.size.height)];
    [_sliderButton setBackgroundColor:[UIColor redColor]];
    [_sliderButton addTarget:self action:@selector(sliderDragged:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [_sliderButton addTarget:self action:@selector(sliderDragExit:forEvent:) forControlEvents:UIControlEventTouchDragExit];
    [_sliderButton addTarget:self action:@selector(sliderDragExit:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sliderButton];
}

#pragma mark - Public Methods

- (void)insertView:(UIView *)view {
    [self updateSliderArrayWithView:view];
    [self updateSliderArrayWithView:view];
}


#pragma mark - Helper Methods

- (void)updateSliderArrayWithView:(UIView *)view {
    [_circularArray insertObject:view atIndex:0];
}

- (void)updateSubviewAllignmentWithView:(id)view {
    [self addSubview:view];
    [_sliderButton removeFromSuperview];
    [self insertSubview:_sliderButton atIndex:0];
}

@end
