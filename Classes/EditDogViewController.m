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


/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view.
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
  [dog update];
  aViewController.dog = dog;
  [self.navigationController popViewControllerAnimated:YES];
  return YES; 
} 


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
  
  [dog release];
  [aViewController release];
  [aTextField release];
  [super dealloc];
}


@end
