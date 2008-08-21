//
//  NSObject+Properties.h
//  medaxion
//
//  Created by Ryan Daigle on 7/28/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

@interface NSObject (PropertySupport)

/**
 * Get the names of all properties declared on this class.
 */
+ (NSArray *)propertyNames;

/**
 * Get all the properties and their values of this instance.
 **/
- (NSDictionary *)properties;

/**
 * Set this object's property values, overriding any existing
 * values.
 */
- (void)setProperties:(NSDictionary *)overrideProperties;
@end
