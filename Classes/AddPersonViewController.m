//
//  AddPersonViewController.m
//  objective_resource
//
//  Created by James Burka on 1/27/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "AddPersonViewController.h"
#import "Person.h"




@implementation AddPersonViewController
@synthesize person , delegate;

- (void)viewWillAppear:(BOOL)animated {
	if(person.personId) {
		self.title = [NSString stringWithFormat:@"Edit %@",person.name,nil];
	}
	else {
		self.title = @"Add Person";
	}
	aTextField.returnKeyType = UIReturnKeyDone; 
	[aTextField becomeFirstResponder];
  [super viewWillAppear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
  [textField resignFirstResponder];
  person.name = textField.text;
	// If the model is new then create will be called otherwise the model will be updated 
  [person saveORS];
	[delegate.tableView reloadData];
  [self.navigationController popViewControllerAnimated:YES];
  return YES; 
} 



- (void)dealloc {
	[super dealloc];
}


@end
