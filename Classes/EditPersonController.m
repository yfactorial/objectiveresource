//
//  EditPersonController.m
//  objective_resource
//
//  Created by James Burka on 1/27/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "EditPersonController.h"


@implementation EditPersonController

@synthesize person, aTextField, aViewController;

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[person release];
	[aTextField release];
	[aViewController release];
    [super dealloc];
}


@end
