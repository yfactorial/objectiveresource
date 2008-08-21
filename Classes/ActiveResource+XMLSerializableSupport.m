//
//  ActiveResource+XML.m
//  medaxion
//
//  Created by Ryan Daigle on 7/24/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "ActiveResource+XMLSerializableSupport.h"
#import "XMLSerializableSupport.h"

@implementation ActiveResource (XMLSerializableSupport)

- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations {
	return [[self properties] toXMLElementAs:rootName excludingInArray:exclusions withTranslations:keyTranslations];
}

@end
