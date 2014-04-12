//
//  MEADeal.m
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import "MEADeal.h"
#import "MEAUser.h"

@implementation MEADeal


- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"user"]) {
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.user = [MEAUser instanceFromDictionary:value];
        }
        
    } else {
        [super setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [super setValue:value forUndefinedKey:key];
}

- (void)getImage:(WebServiceCompletionCallback)completionBlock
{
    [[MEAWebService manager] getImageFromUrl:self.src withCompletionHandler:^(UIImage *image, NSError *error) {
        if (!error) {
            completionBlock(image, nil);
        }
        else {
            completionBlock(nil, error);
            
        }
        
    }];
}

@end
