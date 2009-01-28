//
//  AddDogViewController.h
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Dog;
@interface AddDogViewController : UIViewController <UITextFieldDelegate> {

	IBOutlet UITextField *textField;
	Dog *newDog;
	
}

@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) Dog *newDog;

@end
