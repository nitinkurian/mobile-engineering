//
//  MEAWebService.m
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import "MEAWebService.h"

@interface MEAWebService()

@property (nonatomic, strong) NSString *accessURL;
@property (nonatomic, strong) NSOperationQueue *opQueue;
@property (nonatomic, strong) NSMutableData *data;

@end

@implementation MEAWebService

+ (MEAWebService *)manager
{
    static MEAWebService *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MEAWebService alloc] initWithURL:@"http://sheltered-bastion-2512.herokuapp.com/feed.json"];
    });
    
    return instance;
}

/*
 * Initialise network session with an url
 */
- (id)initWithURL:(NSString *)url
{
    if((self = [super init]))
    {
        self.accessURL = url;
        
        // Setup a operation queue for network operations
        self.opQueue = [[NSOperationQueue alloc] init];
        [self.opQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    }
    return self;
}

- (void)getDealsWithCompletionHandler:(WebServiceCompletionCallback)completionCallback
{
    NSURL *reqURL = [NSURL URLWithString:self.accessURL];
    NSURLRequest *req = [NSURLRequest requestWithURL:reqURL];
    WebServiceCallback callback = ^(NSURLResponse *response, NSData *data, NSError *error) {
        NSError *completionError = nil;
        if (data == nil) {
            //An error occurred
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:@"Failed to receive data" forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"MEADomain" code:100 userInfo:errorDetail];
            completionError = error;
            completionCallback(nil,completionError);
        }
        else if (data && [data length] > 0 && error == nil) {
            self.data = [NSMutableData data];
            [self.data appendData:data];
            NSError *jsonParsingError = nil;
    
            NSArray *object = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingAllowFragments error:&jsonParsingError];
            //Check for json parsing error
            if (jsonParsingError) {
                completionError = jsonParsingError;
            }
            completionCallback(object,completionError);
        }
        else {
            completionCallback(nil,error);
        }
        
    };
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:self.opQueue
                           completionHandler:callback];
}

- (void)getImageFromUrl:(NSString *)url withCompletionHandler:(WebServiceCompletionCallback)completionCallback
{
    NSURL *reqURL = [NSURL URLWithString:url];
    NSURLRequest *req = [NSURLRequest requestWithURL:reqURL];
    
    WebServiceCallback callback = ^(NSURLResponse *response, NSData *data, NSError *error) {
        NSError *completionError = nil;
        if (data == nil) {
            //An error occurred
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:@"Failed to receive data" forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"MEADomain" code:100 userInfo:errorDetail];
            completionError = error;
            completionCallback(nil,completionError);
        }
        else if (data && [data length] > 0 && error == nil) {
            UIImage *image = [UIImage imageWithData:data];
            
            completionCallback(image,nil);
        }
        
    };
    [NSURLConnection sendAsynchronousRequest:req
                                       queue:self.opQueue
                           completionHandler:callback];
}

@end
