//
//  NSHTTPURLResponse+Error.h
//  iphone-harvest
//
//  Created by James Burka on 12/23/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

@interface NSHTTPURLResponse(Error) 

-(NSError *) error;
-(BOOL) isSuccess;
+ (NSError *)buildResponseError:(int)statusCode;

@end
