//
//  MEAAvatar.h
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEAObject.h"
#import "MEAWebService.h"

@interface MEAAvatar : MEAObject

@property (nonatomic, copy) NSString *src;
@property (nonatomic, strong) NSNumber *width;
@property (nonatomic, strong) NSNumber *height;

- (void)getImage:(WebServiceCompletionCallback)completionBlock;

@end
