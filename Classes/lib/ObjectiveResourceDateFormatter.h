//
//  ObjectiveResourceDateFormatter.h
//  iphone-harvest
//
//  Created by James Burka on 10/21/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ObjectiveResourceDateFormatter : NSObject {

}

+ (void)setDateFormatString:(NSString *)format;
+ (void)setDateTimeFormatString:(NSString *)format;
+ (NSString *)formatDate:(NSDate *)date;
+ (NSDate *)parseDate:(NSString *)dateString;
+ (NSDate *)parseDateTime:(NSString *)dateTimeString;

@end
