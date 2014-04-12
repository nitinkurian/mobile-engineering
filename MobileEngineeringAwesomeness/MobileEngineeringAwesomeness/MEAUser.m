//
//  MEAUser.m
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import "MEAUser.h"
#import "MEAAvatar.h"

@implementation MEAUser

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"avatar"]) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.avatar = [MEAAvatar instanceFromDictionary:value];
        }
    }
    else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [super setValue:value forUndefinedKey:key];
}

@end
