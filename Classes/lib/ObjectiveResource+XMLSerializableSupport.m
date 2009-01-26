//
//  ObjectiveResource+XML.m
//  
//
//  Created by Ryan Daigle on 7/24/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "ObjectiveResource+XMLSerializableSupport.h"
#import "XMLSerializableSupport.h"

@implementation ObjectiveResource (XMLSerializableSupport)


- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations {
	return [[self properties] toXMLElementAs:rootName excludingInArray:exclusions withTranslations:keyTranslations];
}


@end
