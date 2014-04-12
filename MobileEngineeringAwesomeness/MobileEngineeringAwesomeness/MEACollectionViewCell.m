//
//  MEACollectionViewCell.m
//  MobileEngineeringAwesomeness
//
//  Created by Nitin John on 4/11/14.
//  Copyright (c) 2014 Nitin. All rights reserved.
//

#import "MEACollectionViewCell.h"

@interface MEACollectionViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *desc;
@property (nonatomic, weak) IBOutlet UILabel *attrib;
@property (nonatomic, strong) NSString *buttonRef;

@end

@implementation MEACollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)initializeWithAttrib:(NSString*)attrib
                        desc:(NSString*)desc
                        href:(NSString*)buttonRef
{
    
    self.desc.text = desc;
    self.attrib.text = attrib;
    self.buttonRef = buttonRef;
	
}


@end
