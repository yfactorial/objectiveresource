//
//  NSDictionary+KeyTranslation.h
//  active_resource
//
//  Created by James Burka on 1/15/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSDictionary(KeyTranslation)

+ (NSString *)translationForKey:(NSString *)key withTranslations:(NSDictionary *)keyTranslations;

@end
