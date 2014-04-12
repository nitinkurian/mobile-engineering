//
//  MEADeals.m
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import "MEAModel.h"
#import "MEADeal.h"

@interface MEAModel ()

@property (nonatomic, strong) NSArray *deals;

@end

@implementation MEAModel

- (void)setAttributesFromArray:(NSArray *)array {
    
    if (![array isKindOfClass:[NSArray class]]) {
        return;
    }
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:array.count];
    for (id aDictionary in array) {
        id val = [MEADeal instanceFromDictionary:aDictionary];
        [mArray addObject:val];
    }
    self.deals = mArray;
}

- (void)getAllDealsWithCompletionBlock:(WebServiceCompletionCallback)completionBlock
{

    [[MEAWebService manager] getDealsWithCompletionHandler:^(id JSON, NSError *error) {
        if (!error) {
            [self setAttributesFromArray:JSON];
            completionBlock(self.deals, nil);
        }
        else {
            completionBlock(nil, error);

        }
            
    }];
    
}

@end
