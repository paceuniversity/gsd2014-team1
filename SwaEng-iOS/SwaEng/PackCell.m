//
//  PackCell.m
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "PackCell.h"
@implementation PackCell

- (void)awakeFromNib{
    // Initialization code
    self.packNameLabel.textColor = cornflowerBlue;
    self.packNameLabel.font = FiraLight(20);
}
-(void)setupWithPack:(Pack*)pack {
    self.packNameLabel.text = pack.name;
}
+(CGFloat)height {
    return 50;
}

@end
