//
//  NSObject+Deserialize.h
//  active_resource
//
//  Created by James Burka on 1/19/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

@interface NSObject(Serialize)

+ (id) deserialize:(id)value;
- (id) serialize;

@end
