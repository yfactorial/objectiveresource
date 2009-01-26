//
//  NSDictionary+XMLSerializableSupport.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "ComplexXMLSerializable.h"

@interface NSDictionary (XMLSerializableSupport) <ComplexXMLSerializable>

- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations;
@end
