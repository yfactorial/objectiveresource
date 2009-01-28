//
//  AddPersonViewController.h
//  objective_resource
//
//  Created by James Burka on 1/27/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;
@interface AddPersonViewController : UIViewController <UITextFieldDelegate>  {

	IBOutlet UITextField *aTextField;
	Person *person;
	UITableViewController *delegate;
	
}

@property (nonatomic,retain) Person *person;
@property (nonatomic,retain) UITableViewController *delegate;

@end
