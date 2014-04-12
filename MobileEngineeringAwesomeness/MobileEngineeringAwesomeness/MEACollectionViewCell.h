//
//  MEACollectionViewCell.h
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEACollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

- (void)initializeWithAttrib:(NSString*)attrib
                        desc:(NSString*)desc
                        href:(NSString*)buttonRef;

@end
