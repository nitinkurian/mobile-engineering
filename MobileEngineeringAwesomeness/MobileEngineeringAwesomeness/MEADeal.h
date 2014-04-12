//
//  MEADeal.h
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEAObject.h"
#import "MEAWebService.h"

@class MEAUser;

@interface MEADeal : MEAObject

@property (nonatomic, copy) NSString *attrib;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *href;
@property (nonatomic, copy) NSString *src;
@property (nonatomic, strong) MEAUser *user;

- (void)getImage:(WebServiceCompletionCallback)completionBlock;

@end
