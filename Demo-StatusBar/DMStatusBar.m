//
//  DMStatusBar.m
//  Demo-StatusBar
//
//  Created by apple on 13-5-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "DMStatusBar.h"

static CGFloat moveDur = 0.3;
static CGFloat stayDur = 1;

@interface DMStatusBar ()
{
    UIView *elementView1;
    UIView *elementView2;
    BOOL canAnimation;
    NSInteger num;
    NSMutableArray *infos;
}
@end

@implementation DMStatusBar

+ (id)sharedInstance
{
    static DMStatusBar *statusBar;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        statusBar = [[DMStatusBar alloc]initWithFrame:CGRectMake(200, 0, 120, 20)];
    });
    return statusBar;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor grayColor];
        self.opaque = YES;
        self.clipsToBounds = YES;
        self.windowLevel = UIWindowLevelStatusBar;
        infos = [[NSMutableArray alloc]init];
        canAnimation = YES;
        [self addElement];
    }
    return self;
}

- (void)addElement
{
    elementView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height)];
    elementView1.backgroundColor = [UIColor clearColor];
    [self addSubview:elementView1];
    [elementView1 release];
    UIImageView *iconImageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 2, 16,  [UIApplication sharedApplication].statusBarFrame.size.height-4)];
    iconImageView1.backgroundColor = [UIColor clearColor];
    [elementView1 addSubview:iconImageView1];
    [iconImageView1 release];
    UILabel *infoLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(33, 0, self.frame.size.width-30, [UIApplication sharedApplication].statusBarFrame.size.height)];
    infoLabel1.textColor = [UIColor whiteColor];
    infoLabel1.font = [UIFont systemFontOfSize:11];
    infoLabel1.backgroundColor = [UIColor clearColor];
    [elementView1 addSubview:infoLabel1];
    [infoLabel1 release];
    
    elementView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.frame.size.width, self.frame.size.height)];
    elementView2.backgroundColor = [UIColor clearColor];
    [self addSubview:elementView2];
    [elementView2 release];
    UIImageView *iconImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 2, 16,  [UIApplication sharedApplication].statusBarFrame.size.height-4)];
    iconImageView2.backgroundColor = [UIColor clearColor];
    [elementView2 addSubview:iconImageView2];
    [iconImageView2 release];
    UILabel *infoLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(33, 0, self.frame.size.width-30, [UIApplication sharedApplication].statusBarFrame.size.height)];
    infoLabel2.textColor = [UIColor whiteColor];
    infoLabel2.font = [UIFont systemFontOfSize:11];
    infoLabel2.backgroundColor = [UIColor clearColor];
    [elementView2 addSubview:infoLabel2];
    [infoLabel2 release];
}

- (void)setImageName:(NSString *)imageName labelText:(NSString *)labelText withView:(UIView *)view
{
    for (id obj in view.subviews) {
        if ([[obj class] isSubclassOfClass:[UIImageView class]]) {
            UIImageView *imageView = (UIImageView *)obj;
            imageView.image = [UIImage imageNamed:imageName];
        }
        if ([[obj class] isSubclassOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)obj;
            label.text = labelText;
        }
    }
}

- (void)startAnimationWithView1:(UIView *)view1 view2:(UIView *)view2
{
    canAnimation = NO;
    if (infos.count > 0) {
        NSDictionary *dic1 = [infos objectAtIndex:0];
        [self setImageName:[dic1 objectForKey:@"icon"] labelText:[dic1 objectForKey:@"info"] withView:view1];
        [infos removeObjectAtIndex:0];
    }
    else{
        canAnimation = YES;
        [self performSelector:@selector(hideDMStatusBar) withObject:nil afterDelay:stayDur];
        return;
    }
    view1.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height);
    [UIView animateWithDuration:moveDur animations:^{
        view1.frame = self.bounds;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:stayDur animations:^{
            view1.frame = CGRectMake(0, 0.01, self.bounds.size.width, self.bounds.size.height);
        } completion:^(BOOL finished) {
            [self setImageName:nil labelText:nil withView:view2];
            view2.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height);
            if (infos.count > 0) {
                NSDictionary *dic2 = [infos objectAtIndex:0];
                [self setImageName:[dic2 objectForKey:@"icon"] labelText:[dic2 objectForKey:@"info"] withView:view2];
                [infos removeObjectAtIndex:0];
            }
            [UIView animateWithDuration:moveDur animations:^{
                view1.frame = CGRectMake(0, -20, self.bounds.size.width, self.bounds.size.height);
                view2.frame = self.bounds;
            } completion:^(BOOL finished) {
                view1.frame = CGRectMake(0, 20, self.frame.size.width, self.frame.size.height);
                [self setImageName:nil labelText:nil withView:view1];
                [UIView animateWithDuration:stayDur animations:^{
                    view2.frame = CGRectMake(0, 0.01, self.bounds.size.width, self.bounds.size.height);
                } completion:^(BOOL finished) {
                    [self startAnimationWithView1:elementView1 view2:elementView2];
                    [UIView animateWithDuration:moveDur animations:^{
                        view2.frame = CGRectMake(0, -20, self.bounds.size.width, self.bounds.size.height);
                    } completion:^(BOOL finished) {
                        if (infos.count <= 0) {
                            [self performSelector:@selector(hideDMStatusBar) withObject:nil afterDelay:stayDur+moveDur];
                        }
                    }];
                }];
            }];
        }];
    }];
}

- (void)showDMStatusBarWithInfoArray:(NSArray *)infoArray
{
    self.hidden = NO;
    for (id obj in infoArray)
    {
        [infos addObject:obj];
    }
    if (canAnimation)
    {
        [self startAnimationWithView1:elementView1 view2:elementView2];
    }
}

- (void)hideDMStatusBar
{
    if (infos.count <= 0) {
        self.hidden = YES;
        [self setImageName:nil labelText:nil withView:elementView1];
    }
    
}

@end