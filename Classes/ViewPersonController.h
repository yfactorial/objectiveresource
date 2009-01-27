//
//  ViewPersonController.h
//  objective_resource
//
//  Created by James Burka on 1/27/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person;
@interface ViewPersonController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {

	Person *person;

}

@property (nonatomic , retain) Person *person;
-(void) editPersonButtonWasPressed;


@end
