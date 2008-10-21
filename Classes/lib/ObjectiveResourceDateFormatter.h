//
//  ObjectiveResourceDateFormatter.h
//  iphone-harvest
//
//  Created by James Burka on 10/21/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ObjectiveResourceDateFormatter : NSObject {

}

+ (void)setFormatString:(NSString *)format;
+ (NSString *)formatDate:(NSDate *)date;
+ (NSDate *)parseDate:(NSString *)dateString;

@end
