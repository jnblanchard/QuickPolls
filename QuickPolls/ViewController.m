//
//  ViewController.m
//  QuickPolls
//
//  Created by John Blanchard on 7/28/15.
//  Copyright © 2015 John Blanchard. All rights reserved.
//

#import "ViewController.h"
#import "PollTableViewCell.h"
#import "PollScrollView.h"

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
    self.pollArray = [self.moc executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Poll"] error:nil];
//    NSLog(@"%@", self.pollArray);
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
    [optionTwo setName:@"No, you do not"];
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

-(PollTableViewCell*)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    PollTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    Poll* poll = [self.pollArray objectAtIndex:indexPath.row];
    PollScrollView* scrollView = [PollScrollView initWithPoll:poll withParentView:cell];
    [cell addSubview:scrollView];
    return cell;
}


@end
