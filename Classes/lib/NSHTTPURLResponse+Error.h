//
//  NSHTTPURLResponse+Error.h
//  iphone-harvest
//
//  Created by James Burka on 12/23/08.
//  Copyright 2008 Burkaprojects. All rights reserved.
//

@interface NSHTTPURLResponse(Error) 

-(NSError *) errorWithBody:(NSData *)data;
-(BOOL) isSuccess;
+ (NSError *)buildResponseError:(int)statusCode withBody:(NSData *)data;
+ (NSArray *)errorArrayForBody:(NSData *)data;
@end
