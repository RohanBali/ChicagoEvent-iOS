//
//  SliderView.h
//  ChicagoEvent
//
//  Created by Rohan Bali on 2012-11-11.
//  Copyright (c) 2012 Rohan Bali. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SliderView : UIView {
    NSMutableArray *_circularArray;
    UIButton *_rightSliderButton;
}

- (void)insertView:(UIView *)view;
- (void)disableSliderHidden;

@end
