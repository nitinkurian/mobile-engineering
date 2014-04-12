//
//  MEAUser.h
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MEAObject.h"

@class MEAAvatar;

@interface MEAUser : MEAObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) MEAAvatar *avatar;

@end
