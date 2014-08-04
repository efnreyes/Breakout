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
#import "BlockView.h"

@interface ViewController () <UICollisionBehaviorDelegate>
@property (strong, nonatomic) IBOutlet PaddleView *paddleView;
@property (strong, nonatomic) IBOutlet BallView *ballView;
@property UIDynamicAnimator *dynamicAnimator;
@property UIPushBehavior *pushBehavior;
@property UICollisionBehavior *collisionBehavior;
@property UIDynamicItemBehavior *paddleDynamicBehavior;
@property UIDynamicItemBehavior *ballDynamicBehavior;
@property UIDynamicItemBehavior *blockDynamicBehavior;
@property NSMutableArray *blocks;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.ballView] mode:UIPushBehaviorModeInstantaneous];
    self.pushBehavior.pushDirection = CGVectorMake(0.5, -1.0);
    self.pushBehavior.active = YES;
    self.pushBehavior.magnitude = 0.04;

    [self.dynamicAnimator addBehavior:self.pushBehavior];

    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.ballView, self.paddleView]];
    self.collisionBehavior.collisionDelegate = self;
    self.collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;

    [self.dynamicAnimator addBehavior:self.collisionBehavior];

    self.paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.paddleView]];
    self.paddleDynamicBehavior.allowsRotation = NO;
    self.paddleDynamicBehavior.density = 1000;

    [self.dynamicAnimator addBehavior:self.paddleDynamicBehavior];

    self.ballDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.ballView]];
    self.ballDynamicBehavior.allowsRotation = NO;
    self.ballDynamicBehavior.elasticity = 1.0;
    self.ballDynamicBehavior.friction = 0;
    self.ballDynamicBehavior.resistance = 0;
    
    [self.dynamicAnimator addBehavior:self.ballDynamicBehavior];

//  Adding boundarie to collision behavior
    [self.collisionBehavior addBoundaryWithIdentifier:@"bottomLine" fromPoint:CGPointMake(0.0f, [self.view frame].size.height) toPoint:CGPointMake([self.view frame].size.width, [self.view frame].size.height)];

    [self setUpBoard];

    self.blockDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:self.blocks];
    self.blockDynamicBehavior.allowsRotation = NO;
    self.blockDynamicBehavior.density = 1000;

    [self.dynamicAnimator addBehavior:self.blockDynamicBehavior];
}

-(void)setUpBoard {
    BlockView *block;
    int xDelta = 0;
    self.blocks = [[NSMutableArray alloc] init];

    for (int i = 0; i < 5; i++) {
        block = [[BlockView alloc] initWithFrame:CGRectMake(xDelta, 50, 14, 14)];
        [block setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:block];
        [self.blocks addObject:block];
        [self.collisionBehavior addItem:block];
        xDelta += 15;
    }
}

#pragma mark UICollisionBehaviorDelegate methods

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    if ([@"bottomLine" isEqualToString:(NSString*)identifier]) {
//      Touch the bottom of the screen, relocating ball at the center of the screen
        self.ballView.center = CGPointMake(self.view.center.x, self.view.center.y);
        [self.dynamicAnimator updateItemUsingCurrentState:self.ballView];
    }
}

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p {
    BlockView *bv;
    NSLog(@"blockDynamicBehavior %d", [self.blockDynamicBehavior.items count]);
    NSLog(@"collisionBehavior %d", [self.collisionBehavior.items count]);
    if ([item2 isKindOfClass:[BlockView class]]) {
        NSLog(@"Hit the block");
        bv = (BlockView *) item2;
        [self.blockDynamicBehavior removeItem:item2];
        [self.collisionBehavior removeItem:item2];
        [bv removeFromSuperview];
    }
}

#pragma mark Actions
- (IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer {
    self.paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x, self.paddleView.center.y);
    [self.dynamicAnimator updateItemUsingCurrentState:self.paddleView];

}

-(IBAction)ballHitBlock:(id)sender {
    NSLog(@"The ball hit the block");

}

@end
