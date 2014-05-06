//
//  FlashcardCell.h
//  SwaEng
//
//  Created by Michael Cornell on 3/31/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface FlashcardCell : UICollectionViewCell

@property (strong, nonatomic) NSString *backText;
@property (strong, nonatomic) NSString *frontText;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

-(void)setupWithDictEntry:(Card*)card isAlreadyFlipped:(BOOL)isAlreadyFlipped;
+(CGSize)cellSize;
-(void)flip;
-(void)flipUp;
-(void)flipDown;


@end
