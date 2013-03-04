//
//  NLSideNavViewController.m
//  SideNavDemo
//
//  Created by 陈 凯 on 13-2-27.
//  Copyright (c) 2013年 Nono. All rights reserved.
//

#import "NLSideNavViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface NLSideNavViewController ()
{
    @private
    CURRENT_FLAG c_flag;
    
    struct {
        unsigned int respondsToWillShowViewController:1;
        unsigned int leftAvailable:1;
        unsigned int rightAvailable:1;
    } _menuFlags;
    
    
    CGFloat _panOriginX;
    CGPoint _panVelocity;
    SidePanDirection panDirection;
    
}

@property(nonatomic,readonly) UITapGestureRecognizer *tap;
@property(nonatomic,readonly) UIPanGestureRecognizer *pan;

@end


@implementation NLSideNavViewController
@synthesize rootVC,leftVC,rightVC,side_l,side_r,tap,pan;

- (void)dealloc
{
    [rootVC release];
    [leftVC release];
    [rightVC release];
    [super dealloc];
}

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
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - some init menthods
-(void)initData
{
    c_flag = Root;
    side_l = dSIDE_L;
    side_r = dSIDE_R;
    
}
-(id)initWithRootView:(UIViewController *)root
{
    if (self = [super init]) {
        
        self.rootVC = root;
        [self initData];
    }
    return self;
}


#pragma mark - Show methods
-(void)showLeftViewController
{
    
    UIView *lView = leftVC.view;
    [self.view insertSubview:lView atIndex:0];
    CGRect frame;
    frame =  rootVC.view.frame;
    frame.origin.x = side_l;
    NSTimeInterval duration = fabs(rootVC.view.frame.origin.x - frame.origin.x)/320*0.8;
    [self restRootShadow];

    [UIView animateWithDuration:duration animations:^{
        rootVC.view.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)showRightViewController
{
    UIView *rView = rightVC.view;
    [self.view insertSubview:rView atIndex:0];
    
    CGRect frame;
    frame =  rootVC.view.frame;
    frame.origin.x = (-side_r);
    
    NSTimeInterval duration = fabs(rootVC.view.frame.origin.x - frame.origin.x)/320*0.8;
    [self restRootShadow];

    [UIView animateWithDuration:duration animations:^{
        rootVC.view.frame = frame;

    } completion:^(BOOL finished) {
        
    }];

    
}

-(void)showRootViewController;
{
    [self restRootViewNavBar];
    
    CGRect frame = rootVC.view.frame;
    
    frame.origin.x = 0.0;
    NSTimeInterval duration = fabs(rootVC.view.frame.origin.x - frame.origin.x)/320*0.8;
    [self restRootShadow];

    [UIView animateWithDuration:duration animations:^{
        rootVC.view.frame = frame;

    } completion:^(BOOL finished) {
        if (leftVC && leftVC.view.superview) {
            [leftVC.view removeFromSuperview];
        }
        
        if (rightVC && rightVC.view.superview) {
            [rightVC.view removeFromSuperview];
        }

    }];
    


}

-(void)showCurrentViewController
{
    
    switch (c_flag) {
        case Root:
            
            [self showRootViewController];
            break;
            
        case Left:
            [self showLeftViewController];
            break;
            
        case Rigth:
            
            [self showRightViewController];
            break;

    }
}


#pragma mark - rest  method
//重置
-(void)restRootViewNavBar
{
    if (!rootVC)
        return;

    
    UIViewController *topVC;
    
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav =(UINavigationController*)rootVC;
        if ([nav viewControllers].count > 0) {
            topVC = [[nav viewControllers] objectAtIndex:0];
        }else return;
    }else{
        topVC = rootVC;
    }
    
    if (_menuFlags.leftAvailable) {
        UIBarButtonItem *lBtn = [[UIBarButtonItem alloc] initWithTitle:@"左侧" style:UIBarButtonItemStyleDone target:self action:@selector(leftPressed:)];
        
        topVC.navigationItem.leftBarButtonItem = lBtn;
    }
    
    if (_menuFlags.rightAvailable) {
        UIBarButtonItem *lBtn = [[UIBarButtonItem alloc] initWithTitle:@"右侧" style:UIBarButtonItemStyleDone target:self action:@selector(rigthPressed:)];
        topVC.navigationItem.rightBarButtonItem = lBtn;
    }
    
  
}

//重置 rootView的阴影效果
-(void)restRootShadow
{
    if (!rootVC)
        return;
    
    if (c_flag == Root) {
        rootVC.view.layer.shadowOpacity = 0.0f;        
        
    }else {
        
     
        rootVC.view.layer.opacity = 0.8f;
        rootVC.view.layer.shadowOpacity =  0.8f;
        rootVC.view.layer.cornerRadius = 10.0f;
        rootVC.view.layer.shadowOffset = (c_flag==Left)?CGSizeMake(-10, 0):CGSizeMake(10, 10);
        rootVC.view.layer.shadowRadius = 10.0f;
        rootVC.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    }
}


#pragma mark - navbar buttons pressed methods
-(void)leftPressed:(id)sender
{
    
    if (c_flag == Root) {
        c_flag = Left;
    }else if(c_flag == Left){
        c_flag = Root;
    }

    [self showCurrentViewController];
   
}

-(void)rigthPressed:(id)sender
{
    
    if (c_flag == Root) {
        c_flag = Rigth;
    }else if(c_flag == Rigth){
        c_flag = Root;
    }
    
    [self showCurrentViewController];
    
}


#pragma mark - setter
-(void)setLeftVC:(UIViewController *)newVc
{
    if(leftVC){

        [leftVC release];
    }
    leftVC = [newVc retain];
    leftVC.view.frame = self.view.bounds;

    _menuFlags.leftAvailable = (leftVC!=nil);
    [self restRootViewNavBar];

}

-(void)setRightVC:(UIViewController *)newVc
{
    if (rightVC) {
        [rightVC release];
    }
    
    [rightVC = newVc retain];
    rightVC.view.frame = self.view.bounds;

    _menuFlags.rightAvailable = (rightVC!=nil);

    [self restRootViewNavBar];
}

-(void)setRootVC:(UIViewController *)newVc
{
    if (rootVC) {
        [rootVC.view removeFromSuperview];
        [rootVC release];
    }
    rootVC = [newVc retain];

    if (rootVC) {
    
        rootVC.view.frame = self.view.bounds;
        [self.view addSubview:rootVC.view];
        [self restRootViewNavBar];
        pan =[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.delegate = self;
        [rootVC.view addGestureRecognizer:pan];
        
    }
    pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.delegate = self;
    [rootVC.view addGestureRecognizer:pan];

}


#pragma mark - GestureRecognizers

- (void)pan:(UIPanGestureRecognizer*)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        //显示阴影效果
        [self restRootShadow];
        
        //获取rootview原点的x
        _panOriginX = rootVC.view.frame.origin.x;
        //拖动的速率初始化
        _panVelocity = CGPointMake(0.0f, 0.0f);
        
        //判断是往左还是往右拖动
        if([gesture velocityInView:self.view].x > 0) {
                panDirection = SidePanDirectionRight;
            
        } else {
                panDirection = SidePanDirectionLeft;
        }
        
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        
        
        //获取拖动的速率；
        CGPoint velocity = [gesture velocityInView:self.view];
        //根据前一个和现在的速率判断是否要改变方向
        if((velocity.x*_panVelocity.x + velocity.y*_panVelocity.y) < 0) {
    
            panDirection = (panDirection == SidePanDirectionRight) ? SidePanDirectionLeft : SidePanDirectionRight;
        }
        
        _panVelocity = velocity;
        //拖动的距离
        CGPoint translation = [gesture translationInView:self.view];
        /**
         下面是rootview拽动改变
         */
        CGRect frame = rootVC.view.frame;
        frame.origin.x = _panOriginX + translation.x;
        if (c_flag == Root) {
            if (frame.origin.x > 0.0f) {
                if (_menuFlags.leftAvailable) {
                    c_flag = Left;
                    [self showCurrentViewController];
                }else{
                    frame.origin.x = 0;
                }
            }else{
                if (_menuFlags.rightAvailable) {
                    c_flag = Rigth;
                    [self showCurrentViewController];
                }else{
                    frame.origin.x = 0.0f; 
                    
                }

            }
        }else if (c_flag == Left){

            if(frame.origin.x <0)
                frame.origin.x = 0.0;
            
        }else if (c_flag == Rigth){
        
            if (frame.origin.x >0) {
                frame.origin.x  = 0;
            }
        }
        
        NSLog(@"change！！！！！");
        rootVC.view.frame = frame;
        
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        NSLog(@"end！！！！！");
        [self.view setUserInteractionEnabled:NO];
        
        SidePanCompletion completion =SidePanCompletionRoot;
        if (panDirection == SidePanDirectionRight && _menuFlags.leftAvailable) {
           
            if(rootVC.view.frame.origin.x > 0.0f )
            completion = SidePanCompletionLeft;
        } else if (panDirection == SidePanDirectionLeft && _menuFlags.rightAvailable) {
            if(rootVC.view.frame.origin.x < 0.0f )
            completion = SidePanCompletionRight;
        }
        
        CGPoint velocity = [gesture velocityInView:self.view];
        if (velocity.x < 0.0f) {
            velocity.x *= -1.0f;
        }
        BOOL bounce = (velocity.x > 800);
        CGFloat originX = rootVC.view.frame.origin.x;
        CGFloat width = rootVC.view.frame.size.width;
        CGFloat span = (width - kMenuOverlayWidth( fabs( side_l)));
        CGFloat duration = kMenuSlideDuration; // default duration with 0 velocity
        
        
        if (bounce) {
            duration = (span / velocity.x); // bouncing we'll use the current velocity to determine duration
        } else {
            duration = ((span - originX) / span) * duration; // user just moved a little, use the defult duration, otherwise it would be too slow
        }
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            if (completion == SidePanCompletionLeft) {
                c_flag = Left;
               
            } else if (completion == SidePanCompletionRight) {
                c_flag = Rigth;
            } else {
                c_flag = Root;
            }
            [self showCurrentViewController];

            [rootVC.view.layer removeAllAnimations];
            [self.view setUserInteractionEnabled:YES];
        }];
        
        CGPoint pos = rootVC.view.layer.position;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        
        NSMutableArray *keyTimes = [[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2];
        NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2];
        NSMutableArray *timingFunctions = [[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2];
        
        [values addObject:[NSValue valueWithCGPoint:pos]];
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [keyTimes addObject:[NSNumber numberWithFloat:0.0f]];
        if (bounce) {
            
            duration += kMenuBounceDuration;
            [keyTimes addObject:[NSNumber numberWithFloat:1.0f - ( kMenuBounceDuration / duration)]];
            if (completion == SidePanCompletionLeft) {
                
                [values addObject:[NSValue valueWithCGPoint:CGPointMake(((width/2) + span) + kMenuBounceOffset, pos.y)]];
                
            } else if (completion == SidePanCompletionRight) {
                
                [values addObject:[NSValue valueWithCGPoint:CGPointMake(-((width/2) - (kMenuOverlayWidth(fabs(side_r))-kMenuBounceOffset)), pos.y)]];
                
            } else {
                
                // depending on which way we're panning add a bounce offset
                if (panDirection == SidePanDirectionLeft) {
                    [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) - kMenuBounceOffset, pos.y)]];
                } else {
                    [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) + kMenuBounceOffset, pos.y)]];
                }
                
            }
            
            [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            
        }
        if (completion == SidePanCompletionLeft) {
            [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) + span, pos.y)]];
        } else if (completion == SidePanCompletionRight) {
            [values addObject:[NSValue valueWithCGPoint:CGPointMake(-((width/2) - kMenuOverlayWidth(side_r)), pos.y)]];
        } else {
            [values addObject:[NSValue valueWithCGPoint:CGPointMake(width/2, pos.y)]];
        }
        
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [keyTimes addObject:[NSNumber numberWithFloat:1.0f]];
        
        animation.timingFunctions = timingFunctions;
        animation.keyTimes = keyTimes;
        //animation.calculationMode = @"cubic";
        animation.values = values;
        animation.duration = duration;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [rootVC.view.layer addAnimation:animation forKey:nil];
        [CATransaction commit];
        
    }
    
}

- (void)tap:(UITapGestureRecognizer*)gesture {
    
    [gesture setEnabled:NO];
    [self showCurrentViewController];
    
}

#pragma mark - UIGestureRecognizerDelegate methods

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    // Check for horizontal pan gesture
    if (gestureRecognizer == pan) {
        
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:self.view];
        
        if ([panGesture velocityInView:self.view].x < 600 && sqrt(translation.x * translation.x) / sqrt(translation.y * translation.y) > 1) {
            return YES;
        }
        
        return NO;
    }
    
    if (gestureRecognizer == tap) {
        
        if (rootVC && c_flag!=Root) {
            return CGRectContainsPoint(rootVC.view.frame, [gestureRecognizer locationInView:self.view]);
        }
        
        return NO;
        
    }
    
    return YES;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer==tap) {
        return YES;
    }
    return NO;
}



@end
