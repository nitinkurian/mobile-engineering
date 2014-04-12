//
//  MEAAvatar.m
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import "MEAAvatar.h"

@implementation MEAAvatar

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
