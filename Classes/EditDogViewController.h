//
//  EditDogViewController.h
//  active_resource
//
//  Created by James Burka on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dog;
@class ViewDogController;

@interface EditDogViewController : UIViewController <UITextFieldDelegate> {
  
  Dog * dog;
  IBOutlet UITextField * aTextField;
  ViewDogController * aViewController;
  
}

@property (nonatomic , retain) Dog * dog;
@property (nonatomic , retain) UITextField * aTextField;
@property (nonatomic , retain) ViewDogController * aViewController;

@end
