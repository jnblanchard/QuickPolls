//
//  PollScrollView.h
//  QuickPolls
//
//  Created by John Blanchard on 7/31/15.
//  Copyright © 2015 John Blanchard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Poll.h"


@interface PollScrollView : UIScrollView

@property Poll* poll;

+ (CGFloat) getRandColor;
+ (PollScrollView*) initWithPoll:(Poll*)poll withParentView:(UIView*)view;

@end
