//
//  CalculatorViewController.m
//  Demo-StatusBar
//
//  Created by apple on 13-5-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CalculatorViewController.h"
#import "DMStatusBar.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    //    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(show) userInfo:nil repeats:YES];
    //    [timer fire];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"show" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 100, 66);
    btn.center = self.view.center;
    [self.view addSubview:btn];
}

- (void)show{
    DMStatusBar *status = [DMStatusBar sharedInstance];
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setObject:@"mail" forKey:@"icon"];
    [dic1 setObject:@"duomi1" forKey:@"info"];
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    [dic2 setObject:@"mail" forKey:@"icon"];
    [dic2 setObject:@"duomi2" forKey:@"info"];
    NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
    [dic3 setObject:@"mail" forKey:@"icon"];
    [dic3 setObject:@"duomi3" forKey:@"info"];
    NSMutableDictionary *dic4 = [NSMutableDictionary dictionary];
    [dic4 setObject:@"mail" forKey:@"icon"];
    [dic4 setObject:@"duomi4" forKey:@"info"];
    NSMutableDictionary *dic5 = [NSMutableDictionary dictionary];
    [dic5 setObject:@"mail" forKey:@"icon"];
    [dic5 setObject:@"duomi5" forKey:@"info"];
    NSArray *array = [NSArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5, nil];
    [status showDMStatusBarWithInfoArray:array];
}

- (void)hide{
    DMStatusBar *status = [DMStatusBar sharedInstance];
    [status hideDMStatusBar];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
