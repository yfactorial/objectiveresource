//
//  active_resourceAppDelegate.m
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright Joshua Vickery 2008. All rights reserved.
//

#import "active_resourceAppDelegate.h"

@implementation active_resourceAppDelegate

@synthesize window, navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	[window addSubview:navigationController.view];
	
	// Override point for customization after app launch	
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end
