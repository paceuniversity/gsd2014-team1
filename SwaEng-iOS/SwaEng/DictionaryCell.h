//
//  DictionaryCell.h
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@class DictionaryCell;
@protocol DictionaryCellDelegate <NSObject>

-(void)phraseWasEditted:(DictionaryCell*)cell;
-(void)translationWasEditted:(DictionaryCell*)cell;

@end

@interface DictionaryCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phraseField;
@property (weak, nonatomic) IBOutlet UITextField *translationField;
@property (weak, nonatomic) id<DictionaryCellDelegate> delegate;
-(void)setupWithDictEntry:(Card*)card;
+(CGFloat)height;

@end
