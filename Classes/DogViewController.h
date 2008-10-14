//
//  DogViewController.h
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddDogViewController;


@interface DogViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {

	NSMutableArray *dogs;
	AddDogViewController *addController;
	IBOutlet UITableView *tableView;
  IBOutlet UIBarButtonItem * addButton;
	
}

@property(nonatomic , retain) NSArray *dogs;
@property(nonatomic , retain) AddDogViewController *addController;
@property(nonatomic , retain) UITableView *tableView;
@property(nonatomic , retain) UIBarButtonItem * addButton;

- (IBAction) addDogButtonClicked:(id) sender;

@end
