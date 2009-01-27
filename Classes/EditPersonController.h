//
//  EditPersonController.h
//  objective_resource
//
//  Created by James Burka on 1/27/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Person , ViewPersonController;
@interface EditPersonController : UIViewController {

  Person * person;
  IBOutlet UITextField * aTextField;
  ViewPersonController * aViewController;
  
}

@property (nonatomic , retain) Person * person;
@property (nonatomic , retain) UITextField * aTextField;
@property (nonatomic , retain) ViewPersonController * aViewController;

@end
