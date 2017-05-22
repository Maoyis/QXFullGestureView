//
//  QXViewController.m
//  QXFullGestureView
//
//  Created by Maoyis on 05/18/2017.
//  Copyright (c) 2017 Maoyis. All rights reserved.
//

#import "QXViewController.h"

#import <QXFullGestureView/QXGestureView.h>

@interface QXViewController ()

@property (weak, nonatomic) IBOutlet QXGestureView *gView;

@end

@implementation QXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    __block CGRect rect = self.gView.frame;
    self.gView.panBlock = ^(UIPanGestureRecognizer *pan) {
        if (pan.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
                self.gView.frame = rect;
                self.gView.center = self.view.center;
            } completion:nil];
        }
    };
    self.gView.isMove = YES;
    self.gView.isPinch = YES;
    self.gView.isRotation = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
