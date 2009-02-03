//
//  AddDogViewController.m
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import "AddDogViewController.h"
#import "Dog.h"

@implementation AddDogViewController

@synthesize textField , newDog;

#pragma mark UIViewController methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"Add a new dog";
	}
	return self;
}

- (void)viewDidAppear:(BOOL)animated {
	[self.textField becomeFirstResponder];
}

#pragma mark UITextFieldDelegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	newDog.name = textField.text;
	
	// explicitly create a new dog on the server
	[newDog createRemote];
	[self.navigationController popViewControllerAnimated:YES];
	return YES;
}

#pragma mark cleanup

- (void)dealloc {
	[newDog release];
	[textField release];
	[super dealloc];
}


@end
