//
//  MEAWebService.h
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WebServiceCallback)(NSURLResponse *response, NSData *data, NSError *connectionError);
typedef void (^WebServiceCompletionCallback)(id JSON , NSError *error);

@interface MEAWebService : NSObject

+ (MEAWebService *)manager;

- (void)getDealsWithCompletionHandler:(WebServiceCompletionCallback)completionCallback;
- (void)getImageFromUrl:(NSString *)url withCompletionHandler:(WebServiceCompletionCallback)completionCallback;

@end
