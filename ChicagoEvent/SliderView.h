//
//  SliderView.h
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-11.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

//TODO: There is a bug when you can interact with both left and right slider independently

#import <UIKit/UIKit.h>

@protocol SliderViewDelegate <NSObject>

- (void)didSlideToIndex:(int)index;

@end


@interface SliderView : UIView {
    NSMutableArray *_circularArray;
    UIButton *_rightSliderButton;
    UIButton *_leftSliderButton;
    NSMutableArray *_staticArray; //this array reflects the initial state of the slider
}

@property (nonatomic, weak) id<SliderViewDelegate> delegate;

- (void)resetSliderAtIndex:(int)index;
- (void)insertView:(UIView *)view;
- (void)disableSliderHidden;

@end
