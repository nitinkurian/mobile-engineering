//
//  MEAObject.m
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import "MEAObject.h"

@implementation MEAObject

+ (instancetype)instanceFromDictionary:(NSDictionary *)aDictionary
{
    id instance = [[[self class] alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
}


- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    [self setValuesForKeysWithDictionary:aDictionary];
    
}


@end
