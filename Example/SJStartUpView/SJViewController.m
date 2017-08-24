//
//  SJViewController.m
//  SJStartUpView
//
//  Created by SoulJaZhao on 08/24/2017.
//  Copyright (c) 2017 SoulJaZhao. All rights reserved.
//

#import "SJViewController.h"
#import <SJStartUpView/SJStartUpView.h>

@interface SJViewController () <SJStartUpViewDelegate>

@end

@implementation SJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    SJStartUpView *startUpView = [[SJStartUpView alloc] initWithImage:[UIImage imageNamed:@"vans"] countTime:10];
    startUpView.frame = self.view.bounds;
    startUpView.delegate = self;
    [self.view addSubview:startUpView];
}

#pragma mark - SJStartUpViewDelegate
- (void)dismissStartUpView:(SJStartUpView *)startUpView {
    NSLog(@"结束");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
