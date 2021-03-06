//
//  SliderView.m
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-11.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import "SliderView.h"
#import "TicketsView.h"

@interface SliderView()

- (void)setupSliderButtons;
- (void)updateSliderArrayWithView:(UIView *)view;
- (void)updateSubviewAllignmentWithView:(UIView *)view;

- (void)switchViewsPopTop;
- (void)switchViewsBringBottomUp;
- (void)switchViewsResetBottom;

- (void)shiftArrayPopTop;
- (void)shiftArrayAddBottom;
- (void)animateSliderIn:(UIControl *)control;


@end

@implementation SliderView

@synthesize delegate = _delegate;

- (id)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0f, 0.0f , 240.0f , 44.0f);
        _circularArray = [[NSMutableArray alloc] init];
        _staticArray = [[NSMutableArray alloc] init];
        [self setClipsToBounds:YES];
        [self setupSliderButtons];
    }
    return self;
}

#pragma mark - Setup Methods

- (void)setupSliderButtons {
    _rightSliderButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 20.0f, 0.0f, 20.0f, self.frame.size.height)];
    [_rightSliderButton setBackgroundColor:[UIColor redColor]];
    [_rightSliderButton addTarget:self action:@selector(rightSliderDragged:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [_rightSliderButton addTarget:self action:@selector(rightSliderDragExit:forEvent:) forControlEvents:UIControlEventTouchDragExit];
    [_rightSliderButton addTarget:self action:@selector(rightSliderDragExit:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightSliderButton];

    _leftSliderButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 20.0f, self.frame.size.height)];
    [_leftSliderButton setBackgroundColor:[UIColor redColor]];
    [_leftSliderButton addTarget:self action:@selector(leftSliderDragged:forEvent:) forControlEvents:UIControlEventTouchDragInside];
    [_leftSliderButton addTarget:self action:@selector(leftSliderDragExit:forEvent:) forControlEvents:UIControlEventTouchDragExit];
    [_leftSliderButton addTarget:self action:@selector(leftSliderDragExit:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftSliderButton];

}

#pragma mark - Public Methods

- (void)resetSliderAtIndex:(int)index {
    if ([_staticArray count] > index) {
        while ([_circularArray objectAtIndex:0] != [_staticArray objectAtIndex:index]) {
            [self switchViewsPopTop];
        }
    }
    return;
}

- (void)insertView:(UIView *)view {
    [self updateSliderArrayWithView:view];
    [self updateSubviewAllignmentWithView:view];
    [_staticArray insertObject:view atIndex:0];
}

- (void)disableSliderHidden {
    [_rightSliderButton setBackgroundColor:[UIColor redColor]];
    [_leftSliderButton setBackgroundColor:[UIColor redColor]];
}

#pragma mark - Public Methods Helper Methods

- (void)updateSliderArrayWithView:(UIView *)view {
    [_circularArray insertObject:view atIndex:0];
}

- (void)updateSubviewAllignmentWithView:(id)view {
    [self addSubview:view];
    [_rightSliderButton removeFromSuperview];
    [_leftSliderButton removeFromSuperview];
    [self insertSubview:_leftSliderButton aboveSubview:view];
    [self insertSubview:_rightSliderButton aboveSubview:view];
}

#pragma mark - Slider Methods

- (void)rightSliderDragged:(id)sender forEvent:(UIEvent *)event {
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    UIControl *control = sender;
    CGRect frame = control.frame;
    UIView *view = [_circularArray objectAtIndex:0];
    __block CGRect viewFrame = view.frame;
    frame.origin.x = roundf(point.x - (frame.size.width / 2.0f));
    if (frame.origin.x >= 0.0f && frame.origin.x <= self.frame.size.width - 20.0f) {
        control.frame = frame;
        viewFrame = view.frame;
        viewFrame.origin.x = CGRectGetMaxX(frame) - viewFrame.size.width;
        view.frame = viewFrame;
        
        CGRect containerViewFrame = [[(TicketsView *)view containerView] frame];
        containerViewFrame.origin.x = 0.0f - viewFrame.origin.x;
        [[(TicketsView *)view containerView] setFrame:containerViewFrame];
    }
}

- (void)rightSliderDragExit:(id)sender forEvent:(UIEvent *)event {
    UIControl *control = sender;
    __block CGRect frame = control.frame;
    UIView *view = [_circularArray objectAtIndex:0];
    __block CGRect viewFrame = view.frame;
    __block CGRect containerViewFrame = [[(TicketsView *)view containerView] frame];

    if (frame.origin.x <  60.0f) {
        [UIView animateWithDuration:0.4
                         animations:^{
                             frame.origin.x = 0.0f;
                             control.frame = frame;
                             viewFrame.origin.x = 0.0f - viewFrame.size.width;
                             view.frame = viewFrame;
                             
                             containerViewFrame.origin.x = 0.0f - viewFrame.origin.x;
                             [[(TicketsView *)view containerView] setFrame:containerViewFrame];
                         }
                         completion:^(BOOL finished){
                             viewFrame.origin.x = self.frame.size.width - viewFrame.size.width;
                             view.frame = viewFrame;
                             
                             containerViewFrame.origin.x = 0.0f;
                             [[(TicketsView *)view containerView] setFrame:containerViewFrame];
                             
                             [self animateSliderIn:control];
                             [self switchViewsPopTop];
                         }];
    } else {
        [UIView animateWithDuration:0.4
                         animations:^{
                             frame.origin.x = self.frame.size.width-frame.size.width;
                             control.frame = frame;
                             
                             viewFrame.origin.x = self.frame.size.width - viewFrame.size.width;
                             view.frame = viewFrame;
                             
                             containerViewFrame.origin.x = 0.0f;
                             [[(TicketsView *)view containerView] setFrame:containerViewFrame];
                             
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

- (void)leftSliderDragged:(id)sender forEvent:(UIEvent *)event {
    CGPoint point = [[[event allTouches] anyObject] locationInView:self];
    UIControl *control = sender;
    CGRect frame = control.frame;

    UIView *view = [_circularArray objectAtIndex:[_circularArray count] - 1];
    [self switchViewsBringBottomUp];
    
    __block CGRect viewFrame = view.frame;

    frame.origin.x = roundf(point.x - (frame.size.width / 2.0f));
    if (frame.origin.x >= 0.0f && frame.origin.x <= self.frame.size.width - 20.0f) {
        control.frame = frame;
        viewFrame = view.frame;
        viewFrame.origin.x = CGRectGetMaxX(frame) - viewFrame.size.width;
        view.frame = viewFrame;
    }
}

- (void)leftSliderDragExit:(id)sender forEvent:(UIEvent *)event {
    UIControl *control = sender;
    __block CGRect frame = control.frame;
    UIView *view = [_circularArray objectAtIndex:[_circularArray count] - 1];
    __block CGRect viewFrame = view.frame;
    
    if (frame.origin.x > self.frame.size.width - 60.0f) {
        [UIView animateWithDuration:0.4
                         animations:^{
                             frame.origin.x = self.frame.size.width - 20.0f;
                             control.frame = frame;
                             viewFrame.origin.x = 0.0f;
                             view.frame = viewFrame;
                         }
                         completion:^(BOOL finished){
                             viewFrame.origin.x = 0.0f;
                             view.frame = viewFrame;
                             [self shiftArrayAddBottom];
                             [self animateSliderIn:control];
                            
                         }];
    } else {
        [UIView animateWithDuration:0.4
                         animations:^{
                             frame.origin.x = 0.0f;
                             control.frame = frame;
                             
                             viewFrame.origin.x = CGRectGetMaxX(frame) - viewFrame.size.width;
                             view.frame = viewFrame;
                         }
                         completion:^(BOOL finished){
                             viewFrame.origin.x = 0.0f;
                             view.frame = viewFrame;
                             [view removeFromSuperview];
                             [self insertSubview:view belowSubview:[_circularArray objectAtIndex:[_circularArray count] - 2]];
                         }];
    }
}


#pragma mark - Slider Helper Methods


- (void)animateSliderIn:(UIControl *)control {
    CGRect frame = control.frame;
    if (control == _rightSliderButton) {
    frame.origin.x = self.frame.size.width-frame.size.width;
    } else {
        frame.origin.x = 0.0f;
    }
    
    [control setAlpha:0.0f];
    control.frame = frame;
    [UIView animateWithDuration:0.6
                     animations:^{
                         control.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                     }];
}

#pragma mark - Array Mehthods

- (void)switchViewsPopTop {
    UIView *view = [_circularArray objectAtIndex:0];
    [view removeFromSuperview];
    [self insertSubview:view belowSubview:[_circularArray objectAtIndex:MAX(0,[_circularArray count] - 1)]];
    
    [self shiftArrayPopTop];
}

- (void)switchViewsResetBottom {
    UIView *view = [_circularArray objectAtIndex:[_circularArray count] - 1];
    [view removeFromSuperview];
    [self insertSubview:view belowSubview:[_circularArray objectAtIndex:[_circularArray count] - 2]];
}

- (void)switchViewsBringBottomUp {
    UIView *view = [_circularArray objectAtIndex:[_circularArray count] - 1];
    [view removeFromSuperview];
    [self insertSubview:view aboveSubview:[_circularArray objectAtIndex:0]];
}

- (void)shiftArrayPopTop {
    UIView *view = [_circularArray objectAtIndex:0];
    [_circularArray removeObjectAtIndex:0];
    [_circularArray addObject:view];
    [self callDelegate];
}

- (void)shiftArrayAddBottom {
    UIView *view = [_circularArray objectAtIndex:[_circularArray count] - 1];
    [_circularArray removeObjectAtIndex:[_circularArray count] - 1];
    [_circularArray insertObject:view atIndex:0];
    [self callDelegate];
}

#pragma mark - Delegate Helper Methods

- (void)callDelegate {
    int index = [_staticArray indexOfObject:[_circularArray objectAtIndex:0]];
    if ([_delegate respondsToSelector:@selector(didSlideToIndex:)]) {
        [_delegate didSlideToIndex:index];
    }
}

@end
