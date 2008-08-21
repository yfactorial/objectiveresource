//
//  NSDate+XMLSerializableSupport.h
//  medaxion
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

@interface NSDate (XMLSerializableSupport)
- (NSString *)toXMLValue;
+ (NSDate *)fromXMLString:(NSString *)xmlString;
@end
