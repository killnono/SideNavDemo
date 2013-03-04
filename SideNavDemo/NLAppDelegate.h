//
//  NLAppDelegate.h
//  SideNavDemo
//
//  Created by 陈 凯 on 13-2-27.
//  Copyright (c) 2013年 Nono. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NLSideNavViewController;
@interface NLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NLSideNavViewController *side_nav;
@end
