//
//  NSDate+Deserialize.h
//  active_resource
//
//  Created by James Burka on 1/19/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

@interface NSDate(Serialize)

+ (NSDate *) deserialize:(id)value;
- (NSString *) serialize; 
@end
