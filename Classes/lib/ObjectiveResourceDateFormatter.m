//
//  ObjectiveResourceDateFormatter.m
//  iphone-harvest
//
//  Created by James Burka on 10/21/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import "ObjectiveResourceDateFormatter.h"


@implementation ObjectiveResourceDateFormatter

static NSString * dateFormatString = @"yyyy-MM-dd'T'HH:mm:ss'Z'";

+ (void)setFormatString:(NSString *)format {
	dateFormatString = format;
}

+ (NSString *)formatDate:(NSDate *)date {
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:dateFormatString];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	return [formatter stringFromDate:date];
	
}

+ (NSDate *)parseDate:(NSString *)dateString {

	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:dateFormatString];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	return [formatter dateFromString:dateString];
	
}


@end
