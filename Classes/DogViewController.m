//
//  DogViewController.m
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import "DogViewController.h"
#import "Dog.h"
#import "AddDogViewController.h"

@interface DogViewController (Private)

- (void) loadDogs;

@end


@implementation DogViewController

@synthesize dogs, addController, tableView;

- (IBAction) addDogButtonClicked:(id) sender {
	[self.navigationController pushViewController:addController animated:YES];
}

- (void) loadDogs {
	self.dogs = [Dog findAll];
	[tableView reloadData];
}

#pragma mark UIViewController methods

- (void)viewDidLoad {
	self.addController = [[[AddDogViewController alloc] initWithNibName:@"AddDogView" bundle:nil] autorelease];
}


- (void)viewWillAppear:(BOOL)animated {
	[self loadDogs];
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return [dogs count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *cellId = @"cellId";
	UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:cellId];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero] autorelease];
	}
	cell.text = ((Dog *)[dogs objectAtIndex:indexPath.row]).name;
	return cell;
}




#pragma mark cleanup
- (void)dealloc {
	[tableView release];
	[addController release];
	[dogs release];
	[super dealloc];
}


@end
