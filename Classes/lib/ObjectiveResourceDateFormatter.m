//
//  ObjectiveResourceDateFormatter.m
//  iphone-harvest
//
//  Created by James Burka on 10/21/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import "ObjectiveResourceDateFormatter.h"


@implementation ObjectiveResourceDateFormatter

static NSString *dateTimeFormatString = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
static NSString *dateFormatString = @"yyyy-MM-dd";


+ (void)setDateFormatString:(NSString *)format {
	dateFormatString = format;
}

+ (void)setDateTimeFormatString:(NSString *)format {
	dateTimeFormatString = format;
}

+ (NSString *)formatDate:(NSDate *)date {
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:dateFormatString];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	return [formatter stringFromDate:date];
	
}

+ (NSDate *)parseDateTime:(NSString *)dateTimeString {

	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:dateTimeFormatString];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	return [formatter dateFromString:dateTimeString];
	
}

+ (NSDate *)parseDate:(NSString *)dateString {
	
	NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[formatter setDateFormat:dateFormatString];
	[formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
	return [formatter dateFromString:dateString];
	
}


@end
