//
//  ViewController.m
//  QuickPolls
//
//  Created by John Blanchard on 7/28/15.
//  Copyright © 2015 John Blanchard. All rights reserved.
//

#import "ViewController.h"
#import "PollTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *pollTitleView;
@property (weak, nonatomic) IBOutlet UIButton *myPollButton;
@property (weak, nonatomic) IBOutlet UIButton *featuredButton;
@property (weak, nonatomic) IBOutlet UITableView *pollTableView;
@property NSArray* pollArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myPollButton.layer.borderColor = [[UIColor blueColor]CGColor];
    self.myPollButton.layer.borderWidth = 1.0;
    self.featuredButton.layer.borderColor = [[UIColor blueColor] CGColor];
    self.featuredButton.layer.borderWidth = 1.0;
    self.pollArray = [self.moc executeFetchRequest:[[NSFetchRequest alloc] initWithEntityName:@"Poll"] error:nil];
    [self.pollTableView reloadData];
    [self switchTextBoldnessInAllButtons];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSArray*) createDummyData
{
    Poll* poll = [NSEntityDescription insertNewObjectForEntityForName:@"Poll" inManagedObjectContext:self.moc];
    [poll setName:@"Do I smell?"];
    Option* optionOne = [NSEntityDescription insertNewObjectForEntityForName:@"Option" inManagedObjectContext:self.moc];
    [optionOne setName:@"Yes, you do"];
    [optionOne setCount:[NSNumber numberWithInt:1]];
    Option* optionTwo = [NSEntityDescription insertNewObjectForEntityForName:@"Option" inManagedObjectContext:self.moc];
    [optionTwo setName:@"No, you do no"];
    [optionTwo setCount:[NSNumber numberWithInt:0]];
    [poll addOptions:[NSSet setWithArray:@[optionOne, optionTwo]]];
    [self.moc save:nil];
    return [NSArray arrayWithObject:poll];
}

- (void) switchTextBoldnessInAllButtons
{
    [self.myPollButton.titleLabel setFont:[UIFont fontWithName:@"Courier-Medium" size:19]];
    [self.featuredButton.titleLabel setFont:[UIFont fontWithName:@"Courier-Medium" size:19]];
}

- (IBAction)myPollButtonPressed:(id)sender
{
    [self switchTextBoldnessInAllButtons];
    [self.myPollButton.titleLabel setFont:[UIFont fontWithName:@"Courier-Bold" size:19]];
}

- (IBAction)featureButtonPressed:(id)sender
{
    [self switchTextBoldnessInAllButtons];
    [self.featuredButton.titleLabel setFont:[UIFont fontWithName:@"Courier-Bold" size:19]];
}


-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pollArray.count;
}

-(UITableViewCell*)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Poll* poll = [self.pollArray objectAtIndex:indexPath.row];
    CGFloat y = 0;
    CGFloat height = cell.frame.size.height/poll.options.count;
    NSLog(@"%@", poll.options);
    for (Option* option in poll.options)
    {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setFrame:CGRectMake(0, y, cell.frame.size.width, height)];
        y += height;
        [button setTitle:option.name forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:rand()/255 green:rand()/255 blue:rand()/255 alpha:1]];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button.titleLabel setTextColor:[UIColor whiteColor]];
        [cell addSubview:button];

    }
    cell.textLabel.text = poll.name;
    return cell;
}


@end
