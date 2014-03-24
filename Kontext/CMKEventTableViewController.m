//
//  CMKEventTableViewController.m
//  Kontext
//
//  Created by Adam Durity on 3/23/14.
//  Copyright (c) 2014 Carnegie Mellon University. All rights reserved.
//

#import "CMKEventTableViewController.h"

@interface CMKEventTableViewController ()

@property NSDictionary *groupedEvents;

@end

@implementation CMKEventTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *eventsDictionaryPath;
    if ((eventsDictionaryPath = [[NSBundle mainBundle] pathForResource:@"Events" ofType:@"plist"])) {
        self.groupedEvents = [NSDictionary dictionaryWithContentsOfFile:eventsDictionaryPath];
    }
    else
    {
        self.groupedEvents = [NSDictionary dictionary];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groupedEvents.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *events = [self.groupedEvents allValues];
    return [events[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle;
    NSArray *sectionKeys = [self.groupedEvents allKeys];

    sectionTitle = sectionKeys[section];
    return sectionTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell" forIndexPath:indexPath];

    NSString *sectionKey = [self.groupedEvents allKeys][indexPath.section];
    NSDictionary *event = self.groupedEvents[sectionKey][indexPath.row];
    cell.textLabel.text = event[@"Name"];
    cell.detailTextLabel.text = event[@"Room"];
    
    return cell;
}

@end
