/**
 * PrivacyScreenPlugin.m
 * Created by Tommy-Carlos Williams on 18/07/2014
 * Copyright (c) 2014 Tommy-Carlos Williams. All rights reserved.
 * MIT Licensed
 */
#import "PrivacyScreenPlugin.h"

#define MY_BACKGROUND_SCREEN_TAG 1001

static UIImageView *imageView;

@implementation PrivacyScreenPlugin

- (void)pluginInitialize
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onAppWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)onAppDidBecomeActive:(UIApplication *)application
{
    // remove blur view if present
    UIView *view = [self.viewController.view viewWithTag:MY_BACKGROUND_SCREEN_TAG];
    if (view != nil)
    {
        [UIView animateWithDuration:0.2f animations:^{
            [view setAlpha:0];
            
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
}

- (void)onAppWillResignActive:(UIApplication *)application
{
    // Visual effect view for blur
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [blurView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [blurView setFrame:[self.viewController.view bounds]];
    blurView.tag = MY_BACKGROUND_SCREEN_TAG;
    [self.viewController.view addSubview:blurView];
}

@end
