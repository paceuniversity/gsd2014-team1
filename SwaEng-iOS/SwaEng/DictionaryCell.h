//
//  DictionaryCell.h
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface DictionaryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *primaryText;
@property (weak, nonatomic) IBOutlet UITextField *secondaryText;
@property (nonatomic) BOOL isEnabled;
-(void)setupWithDictEntry:(Card*)card;
+(CGFloat)height;

@end
