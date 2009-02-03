//
//  EditDogViewController.m
//  active_resource
//
//  Created by James Burka on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Dog.h"
#import "ViewDogController.h"
#import "EditDogViewController.h"


@implementation EditDogViewController

@synthesize dog , aTextField , aViewController;

// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {

    
    
    }
    return self;
}


- (void)viewDidLoad {
  self.title = @"Edit Dog";
  aTextField.returnKeyType = UIReturnKeyDone; 
  aTextField.delegate = self; 
  aTextField.placeholder = @"Dogs Name";
  [ aTextField setText:dog.name];
  [aTextField becomeFirstResponder];
  [super viewDidLoad];

  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField { 
  [textField resignFirstResponder];
  dog.name = textField.text;
  
	// explicitly update a dog on the server
  [dog updateRemote];
  aViewController.dog = dog;
  [self.navigationController popViewControllerAnimated:YES];
  aViewController.title = dog.name;
  [ aViewController.tableView reloadData];
  return YES; 
} 

- (void)dealloc {
  
  [dog release];
  [aViewController release];
  [aTextField release];
  [super dealloc];
}


@end
