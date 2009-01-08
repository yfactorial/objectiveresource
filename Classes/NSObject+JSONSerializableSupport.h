//
//  NSObject+JSONSerializableSupport.h
//  active_resource
//
//  Created by vickeryj on 1/8/09.
//  Copyright 2009 Joshua Vickery. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (JSONSerializableSupport)

+ (id)fromJSONData:(NSData *)data;

@end
