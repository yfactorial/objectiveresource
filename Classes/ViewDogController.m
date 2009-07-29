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

@synthesize dog , editDogButton;

- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {

      self.editDogButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                                                    target:self action:@selector(editDogButtonPressed)];
      
    }
    return self;
}


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
    return 4;
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
  
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init]  autorelease];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
  
    switch (indexPath.section) {
      case 0:
        cell.textLabel.text = dog.name;
        break;
      case 1:
        cell.textLabel.text = dog.dogId;
        break;
      case 2:
        cell.textLabel.text = [dateFormatter stringFromDate:dog.createdAt];
        break;
      case 3:
        cell.textLabel.text = [dateFormatter stringFromDate:dog.updatedAt];
        break;        
      default:
        break;
    }
    // Configure the cell
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  
  // The header for the section is the region name -- get this from the dictionary at the section index
  
  switch (section) {
    case 0:
      return @"Dog's Name";
      break;
    case 1:
      return @"Model Id";
      break;
    case 2:
      return @"Created At";
      break;
    case 3:
      return @"Updated At";
      break;        
    default:
      return @"";
      break;
  }
  
}


- (void)dealloc {
  [dog release];
  [editDogButton release];
  [super dealloc];
}


@end

