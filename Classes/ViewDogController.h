//
//  ViewDogController.h
//  active_resource
//
//  Created by James Burka on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dog;
@class EditDogViewController;

@interface ViewDogController : UITableViewController <UITableViewDelegate, UITableViewDataSource>  {
  
  Dog * dog;
  IBOutlet UITableView *tableView;
  UIBarButtonItem *editDogButton;

}

@property (nonatomic , retain) UIBarButtonItem * editDogButton;
@property (nonatomic , retain) Dog * dog;



@end

@interface ViewDogController () 


-(void)editDogButtonPressed;

@end
