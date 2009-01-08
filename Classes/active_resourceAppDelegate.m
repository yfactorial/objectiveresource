//
//  active_resourceAppDelegate.m
//  active_resource
//
//  Created by vickeryj on 8/21/08.
//  Copyright Joshua Vickery 2008. All rights reserved.
//

#import "active_resourceAppDelegate.h"
#import "ActiveResource+Base.h"

@implementation active_resourceAppDelegate

@synthesize window, navigationController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	
	
	//Configure ActiveResource
	[ActiveResource setSite:@"http://localhost:3000/"];
	//[ActiveResource setProtocolExtension:@".json"];
	//[ActiveResource setParseDataMethod:@selector(fromJSONData:)];
	
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
