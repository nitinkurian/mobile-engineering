//
//  MEADeals.h
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import "MEAObject.h"
#import "MEAWebService.h"

@interface MEAModel : MEAObject

- (void)getAllDealsWithCompletionBlock:(WebServiceCompletionCallback)completionBlock;

@end
