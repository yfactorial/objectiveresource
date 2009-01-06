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

+ (NSString *)fromXmlString:(NSString *)aString {
	NSDictionary* escapeChars = [NSDictionary dictionaryWithObjectsAndKeys:@"&",@"&amp;",@"\"",@"&quot;",@"'",@"&apos;"
															 ,@"<",@"&lt;",@">",@"&gt;",nil];
	return [aString gsub:escapeChars];
	
}

- (NSString *)toXMLValue {
	NSString *temp = [self gsub:[NSDictionary dictionaryWithObject:@"&amp;" forKey:@"&"]];
	NSDictionary* escapeChars = [NSDictionary dictionaryWithObjectsAndKeys:@"&quot;",@"\"",@"&apos;",@"'",@"&lt;",@"<",@"&gt;",@">",nil];
	return [temp gsub:escapeChars];
}
	

@end
