//
//  FlashcardCell.m
//  SwaEng
//
//  Created by Michael Cornell on 3/31/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "FlashcardCell.h"

@interface FlashcardCell ()
@property (nonatomic) BOOL isFrontShowing; //front is no, back is yes
@property (strong, nonatomic) UIFont *moonFlowerBold;
@property (strong, nonatomic) UIFont *moonFlower;
@end

@implementation FlashcardCell

-(void)awakeFromNib {
    self.backgroundColor = [UIColor whiteColor];

    self.bgView.contentMode = UIViewContentModeScaleAspectFit;
    self.bgView.backgroundColor = ivoryWhite;

    self.frontText = @"{front}";
    self.backText = @"{back}";

    self.textLabel.textColor = jetGray;

    self.backgroundColor = [UIColor clearColor];

    self.moonFlower = MoonFlower(50);
    self.moonFlowerBold = MoonFlowerBold(50);

    self.isFrontShowing = YES;

}

-(void)setupWithDictEntry:(Card*)card isAlreadyFlipped:(BOOL)isAlreadyFlipped {
    self.frontText = card.phrase;
    self.backText = card.translation;

    self.isFrontShowing = !isAlreadyFlipped;
    [self flipUnanimated];
}

+(CGSize)cellSize {
    return CGSizeMake(528, 240);
}

-(void)flipUnanimated {
    if (self.isFrontShowing){
        self.textLabel.font = self.moonFlower;
        self.textLabel.text = self.frontText;
    }
    else {
        self.textLabel.font = self.moonFlowerBold;
        self.textLabel.text = self.backText;
    }
}

-(void)_flip:(UIViewAnimationOptions)options{

    self.userInteractionEnabled = NO;
    self.isFrontShowing = !self.isFrontShowing;
    [UIView transitionWithView:self.bgView duration:.25 options:options animations: ^{
        [self flipUnanimated];
    } completion:^(BOOL finished) {
        if (finished) {
            self.userInteractionEnabled = YES;
        }
    }];
}

-(void)flip{
    [self _flip:(self.isFrontShowing) ? UIViewAnimationOptionTransitionFlipFromTop : UIViewAnimationOptionTransitionFlipFromBottom];
}
-(void)flipUp {
    [self _flip:UIViewAnimationOptionTransitionFlipFromBottom];
}
-(void)flipDown {
    [self _flip:UIViewAnimationOptionTransitionFlipFromTop];
}

@end
