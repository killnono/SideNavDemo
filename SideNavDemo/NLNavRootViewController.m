//
//  NLNavRootViewController.m
//  SideNavDemo
//
//  Created by 陈 凯 on 13-2-28.
//  Copyright (c) 2013年 Nono. All rights reserved.
//

#import "NLNavRootViewController.h"

@interface NLNavRootViewController ()

@end

@implementation NLNavRootViewController

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
    UILabel *la = [[UILabel alloc] init];
    la.frame = CGRectMake(40, 100, 200, 100);
    la.text = @"SideNavController_Root";
    
    [self.view addSubview:la];
    [la release];
    self.view.backgroundColor = [UIColor grayColor];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
