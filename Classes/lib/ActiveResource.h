//
//  ActiveResource.h
//  medaxion
//
//  Created by Ryan Daigle on 7/24/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

@interface ActiveResource : NSObject {
  
  NSDate * updatedAt;
  NSDate * createdAt;
  
}

@property (nonatomic , retain) NSDate * createdAt;
@property (nonatomic , retain) NSDate * updatedAt;

@end