Animations & Dynamic Behaviors
==============================

iOS wouldn't be as awesome as it is without animations and dynamic movement. A dynamic animator provides physics-related capabilities and animations for its dynamic items, and provides the context for those animations. It does this by intermediating between the underlying iOS physics engine and dynamic items, via behavior objects you add to the animator.


Breakout
========


As a user, I want to use a paddle
3 points

    Create a new project and name it Breakout
    Create a subclass of UIView and call it PaddleView
    Add a UIView to the ViewController on the Storyboard, make it’s Custom Class PaddleView, and connect it to an IBOutlet named paddleView;
    Add a UIPanGestureRecognizer to the PaddleView on the Storyboard and hook it up to an IBAction called dragPaddle
    Implement the drag behavior, moving the paddleView corresponding to the location of the UIPanGestureRecognizer
    Only adjust the x coordinate of the paddleView

As a user, I want to see a ball
1 point

    Create a subclass of UIView and call it BallView
    Add a UIView to the ViewController on the Storyboard, make it’s Custom Class BallView, and connect it to an IBOutlet named ballView.

As a user, I want to move the ball
2 points

    Add a UIDynamicAnimator as in ivar in the ViewController.m class file and call it dynamicAnimator  (Be sure to update the dynamicAnimator with paddleView’s new location, this can be accomplished through delegation, make the viewController a delegate of the paddleView)
    Instantiate this variable in the viewDidLoad method
    Add a UIPushBehavior as in ivar in the ViewController.m class file and call it pushBehavior
    Instantiate this variable in the viewDidLoad method
    Setup the properties for the pushBehavior and add it to the dynamicAnimator

As a user, I want to hit the ball with the paddle
3 points

    Add a UICollisionBehavior instance variable to the ViewController.m class and call it collisionBehavior
    Instantiate the UICollisionBehavior in the viewDidLoad of the ViewController.m class and assign it’s properties
    Add the collisionBehavior to the dynamicAnimator
    Add a UIDynamicItemBehavior for the paddleView and call it paddleDynamicBehavior
    Instantiate the paddleDynamicBehavior and assign it’s properties
    Disallow rotation for the paddleView through the behavior and add the behavior to the dynamicAnimator

As a user, I want to see the ball bounce off the borders of the phone and keep moving
2 points

    Add a UIDynamicItemBehavior for the ballView and call it ballDynamicBehavior
    Instantiate the ballDynamicBehavior and assign it’s properties
    Disallow rotation for the ballView through the behavior and add the behavior to the dynamicAnimator

As a user, I want to reset the ball if it goes off the bottom of the screen
2 points

    Add the UICollisionBehaviorDelegate protocol to the ViewController.m file and add the delegate method to handle the collisionBehavior withBoundaryIdentifier
    If the y coordinate of the point is nearly off screen, set the center of the ball equal to the center of the ViewController’s view and update the item in the dynamicAnimator

As a user, I want to hit a block
3 points

    Create a class called BlockView and use this class as the Custom class for a new UIView on the ViewController to be placed with the Storyboard 
    Connect the new BlockView/UIView to an IBOutlet called blockView
    Add the block view to the items that the collisionBehavior cares about
    Add a UICollisionBehaviorDelegate method to account for two items colliding
    In the delegate method, establish which item is the block view and remove it from the board

As a user, I want to hit many blocks
3 points

Add multliple blocks to the UI.  Ideally you are adding these blocks programatically so that you can later alter the bock sizes and placement for difficulty settings.  If you want, go ahead and add them through Storyboard but we encourage you to add the blocks programatically in your ViewController's viewDidLoad.
As a user, I want to play again
3 points

    Every time a block is cleared, the method (BOOL)shouldStartAgain should get called
    If all the blocks have been cleared, shouldStartAgain should return true
    Repopulate the board with the blocks *: you can either refactor your project to place blocks programmatically (if you don't already) or store the blocks in an array as you remove from the board to add them back in from the array later.


Stretches
=========


As a user, I want to see some fun things happen when I clear a block
2 points

    Animate the block when clearing it from the board
    Either animate it’s alpha or it’s alpha and color… or do something even cooler!



As a user, I want to have more of a challenge when I play
3 points

    Make some blocks take multiple hits before being destroyed
    Change the color of a block when it’s hit but not destroyed



As a user, I want to see my score
3 points

    Figure out an algorithm to keep score
    This can take into account how many balls have falling off the bottom of the screen, how long it took to clear the board, etc.
    Add a UIAlertView to decide to play again



As a user, I want to play against someone else
3 points

    Keep score for two-players over a few turns
    Alert the winner when all of the turns are completed

