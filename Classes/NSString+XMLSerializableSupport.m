//
//  NSString+XMLSerializableSupport.m
//  active_resource
//
//  Created by James Burka on 1/6/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "NSString+XMLSerializableSupport.h"
#import "NSObject+XMLSerializableSupport.h"
#import "NSString+GSub.h"


@implementation NSString(XMLSerializableSupport)

- (NSString *)toXMLValue {
	NSDictionary* escapeChars = [NSDictionary dictionaryWithObjectsAndKeys:@"&quot;","\"","&apos;","'","&lt;","<","&gt;",">",nil];
	return [self gsub:escapeChars];
}
	

@end
