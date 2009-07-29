//
//  PeopleViewController.m
//  objective_resource
//
//  Created by James Burka on 1/26/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "PeopleViewController.h"
#import "ViewPersonController.h"
#import "Person.h"
#import "AddPersonViewController.h"

@interface PeopleViewController (Private)

- (void) loadPeople;

@end


@implementation PeopleViewController
@synthesize people , tableView;

- (void)viewWillAppear:(BOOL)animated {
	[self loadPeople];
}

- (void) loadPeople {
	self.people = [NSMutableArray arrayWithArray:[Person findAllRemote]];
	[tableView reloadData];
}

-(IBAction) refreshButtonWasPressed {
	[self loadPeople];
}

-(IBAction) addButtonWasPressed {
	AddPersonViewController *aController = [[[AddPersonViewController alloc ] initWithNibName:@"AddPersonView" bundle:nil ] autorelease];
	aController.person = [[Person alloc] init];
	aController.delegate = self;
	[self.navigationController pushViewController:aController animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [people count];
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = ((Person *)[people objectAtIndex:indexPath.row]).name;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ViewPersonController *aController = [[[ViewPersonController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
	aController.person = (Person *)[people objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:aController animated:YES];
}

- (void)tableView:(UITableView *)aTableView  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle 
forRowAtIndexPath:(NSIndexPath *)indexPath { 
  [aTableView beginUpdates]; 
  if (editingStyle == UITableViewCellEditingStyleDelete) { 
		
    [aTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES]; 
		
    // Deletes the object on the resource
    [(Person *)[people objectAtIndex:indexPath.row] destroyRemote];
    [people removeObjectAtIndex:indexPath.row];
  } 
  [aTableView endUpdates];   
}


- (void)dealloc {
	[people release];
  [super dealloc];
}


@end

