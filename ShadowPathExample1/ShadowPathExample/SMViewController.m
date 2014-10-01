//
//  SMViewController.m
//  ShadowPathExample
//
//  Created by Cesare Rocchi on 4/30/14.
//  Copyright (c) 2014 Cesare Rocchi. All rights reserved.
//

#import "SMViewController.h"
@import CoreGraphics;

@interface SMViewController ()

@property (nonatomic, strong) NSMutableArray *animatedViews;

@end

@implementation SMViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.animatedViews = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 200; i++) {
        
        int randX = rand() % (310 - 10) + 10;
        int randY = rand() % (-100 + 10) - 10;
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(randX, randY, 10, 10)];
        [v.layer setShadowOpacity:0.5];
        v.backgroundColor = [self randomColor];
        [self.view addSubview:v];
        [self.animatedViews addObject:v];
        
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    for (UIView *v in self.animatedViews) {
        
        [self animateView:v];
        
    }
    
}

- (void) animateView:(UIView *)view {
    
    CGFloat originalY = view.frame.origin.y;
    int duration = ((float)rand() / RAND_MAX) * 5 + 1;
    [UIView animateWithDuration:duration
                     animations:^{
                         
                         CGRect viewFrame = view.frame;
                         viewFrame.origin.y = 600;
                         view.frame = viewFrame;
                         
                     } completion:^(BOOL finished) {
                         
                         CGRect viewFrame = view.frame;
                         viewFrame.origin.y = originalY;
                         view.frame = viewFrame;
                         [self animateView:view];
                         
                     }];
    
    
}

//- (void) viewTapped {
//
//    [UIView animateWithDuration:1.0f animations:^{
//
//        CGRect frame = self.animatedView.frame;
//        frame.origin.y = 600;
//        self.animatedView.frame = frame;
//
//    }];
//
//}

- (UIColor *) randomColor {
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
