//
//  AddDogViewController.h
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AddDogViewController : UIViewController <UITextFieldDelegate> {

	IBOutlet UITextField *textField;
	
}

@property (nonatomic, retain) UITextField *textField;

@end
