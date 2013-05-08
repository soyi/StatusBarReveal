//
//  DMStatusBar.m
//  Demo-StatusBar
//
//  Created by apple on 13-5-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMStatusBar : UIWindow

+ (id)sharedInstance;
- (void)showDMStatusBarWithInfoArray:(NSArray *)infoArray;
- (void)hideDMStatusBar;

@end
