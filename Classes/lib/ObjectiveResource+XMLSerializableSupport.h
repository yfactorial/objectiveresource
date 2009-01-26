//
//  ObjectiveResource+XML.h
//  
//
//  Created by Ryan Daigle on 7/24/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "ObjectiveResource.h"

@interface ObjectiveResource (XMLSerializableSupport)

- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations;
@end
