//
//  MEAWebViewController.h
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEAWebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSString *loadUrl;

@end
