//
//  PollScrollView.m
//  QuickPolls
//
//  Created by John Blanchard on 7/31/15.
//  Copyright © 2015 John Blanchard. All rights reserved.
//

#import "PollScrollView.h"
#import "Option.h"

@implementation PollScrollView

+ (CGFloat) getRandColor
{
    return rand() / (float) RAND_MAX;
}

+ (PollScrollView*) initWithPoll:(Poll*)poll withParentView:(UIView*)view;
{
    CGFloat x = view.frame.origin.x;
    CGFloat labelHeight = view.frame.size.height * 0.8;
    CGFloat labelWidth = view.frame.size.width * 0.28;
    CGFloat spacingWidth = view.frame.size.width * 0.05;
    CGFloat svWidth = (view.frame.size.width * 0.333) * poll.options.count;
    PollScrollView* sv = [[super alloc] initWithFrame:CGRectMake(x, view.frame.origin.y, svWidth, view.frame.size.height)];
    sv.poll = poll;
    for (Option* option in poll.options)
    {
        NSLog(@"option portrayed by some cell - \n%@\n\n\n", option.name);
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(x, sv.frame.origin.y, labelWidth, labelHeight)];
        x += label.frame.size.width + spacingWidth;
        label.text = option.name;
        label.backgroundColor = [UIColor colorWithRed:[PollScrollView getRandColor] green:[PollScrollView getRandColor] blue:[PollScrollView getRandColor] alpha:1];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [sv addSubview:label];
    }
    UILabel* pollLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.origin.x, view.frame.size.height*0.8, sv.frame.size.width, view.frame.size.height*0.2)];
    pollLabel.text = poll.name;
    pollLabel.textColor = [UIColor whiteColor];
    pollLabel.backgroundColor = [UIColor blackColor];
    [sv addSubview:pollLabel];
    return sv;
}

@end
