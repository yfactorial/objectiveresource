//
//  active_resourceAppDelegate.m
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright Joshua Vickery 2008. All rights reserved.
//

#import "objective_resourceAppDelegate.h"
#import "ObjectiveResource.h"

@implementation objective_resourceAppDelegate

@synthesize window, navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	//Configure ObjectiveResource
	[ObjectiveResource setSite:@"http://localhost:3000/"];
	
	// use json
	[ObjectiveResource setResponseType:JSONResponse];
	
	// use xml
	//[ObjectiveResource setResponseType:XmlResponse];
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
