//
//  NLSideNavViewController.h
//  SideNavDemo
//
//  Created by 陈 凯 on 13-2-27.
//  Copyright (c) 2013年 Nono. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    Left = 0,
    Root,
    Rigth
}CURRENT_FLAG;

typedef enum {
    SidePanDirectionLeft = 0,
    SidePanDirectionRight,
} SidePanDirection;

typedef enum {
    SidePanCompletionLeft = 0,
    SidePanCompletionRight,
    SidePanCompletionRoot,
} SidePanCompletion;


typedef float side_width ;

#define dSIDE_L (200.0)
#define dSIDE_R (260.0)


#define kMenuOverlayWidth(val) (self.view.bounds.size.width - val)
#define kMenuBounceOffset 10.0f
#define kMenuBounceDuration .3f
#define kMenuSlideDuration .3f
@interface NLSideNavViewController : UIViewController<UIGestureRecognizerDelegate>
{

    side_width side_l,side_r;
}
@property(nonatomic,assign)side_width side_l;
@property(nonatomic,assign)side_width side_r;
@property(retain,nonatomic)UIViewController *leftVC;
@property(retain,nonatomic)UIViewController *rightVC;
@property(retain,nonatomic)UIViewController *rootVC;
-(id)initWithRootView:(UIViewController*) root;
@end
