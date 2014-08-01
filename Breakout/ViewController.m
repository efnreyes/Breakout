//
//  ViewController.m
//  Breakout
//
//  Created by Efrén Reyes Torres on 7/31/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "PaddleView.h"
#import "BallView.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet PaddleView *paddleView;
@property (strong, nonatomic) IBOutlet BallView *ballView;
@property UIDynamicAnimator *dynamicAnimator;
@property UIPushBehavior *pushBehavior;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ballView] mode:UIPushBehaviorModeInstantaneous];

    [self.dynamicAnimator addBehavior:self.pushBehavior];
}

- (IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer {
    self.paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x, self.paddleView.center.y);
    [self.dynamicAnimator updateItemUsingCurrentState:self.paddleView];

}

@end
