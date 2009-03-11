//
//  NSError+Error.m
//  objective_resource
//
//  Created by Adam Alexander on 3/10/09.
//  Copyright 2009 yFactorial, LLC. All rights reserved.
//

#import "NSError+Error.h"

@implementation NSError(Error)

-(NSArray *)errors {
	return [self.userInfo valueForKey:NSLocalizedRecoveryOptionsErrorKey];
}

@end
