//
//  ViewDogController.m
//  active_resource
//
//  Created by James Burka on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "Dog.h"
#import "EditDogViewController.h"
#import "ViewDogController.h"





@implementation ViewDogController

@synthesize dog , tableView , editDogButton;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {

      self.editDogButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                                                    target:self action:@selector(editDogButtonPressed)];
      
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {

  self.title = dog.name;
  self.navigationItem.rightBarButtonItem = self.editDogButton;   
  [super viewDidLoad];
}


-(void) editDogButtonPressed {
 
  EditDogViewController * aEditDogViewController = [[EditDogViewController alloc] 
                                                    initWithNibName:@"EditDogViewController" bundle:nil];
  aEditDogViewController.dog = dog;
  aEditDogViewController.aViewController = self;
  [self.navigationController pushViewController:aEditDogViewController animated:YES];
  [aEditDogViewController release];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Dog";
    
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.text = dog.name;
    // Configure the cell
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
  // The header for the section is the region name -- get this from the dictionary at the section index
  
  return @"Name";
  
}


- (void)dealloc {
  [dog release];
  [editDogButton release];
  [tableView release];
  [super dealloc];
}


@end

