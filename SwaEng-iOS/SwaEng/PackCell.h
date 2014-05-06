//
//  PackCell.h
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pack.h"

@interface PackCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *packNameLabel;

-(void)setupWithPack:(Pack*)pack;
+(CGFloat)height;


@end
