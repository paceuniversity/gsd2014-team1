//
//  DictionaryCell.m
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "DictionaryCell.h"

@implementation DictionaryCell

-(void)awakeFromNib {
    self.primaryText.font = FiraLight(17);
    self.secondaryText.font = FiraLight(14);

    self.primaryText.textColor = jetGray;
    self.secondaryText.textColor = jetGray;
}

-(void)setupWithDictEntry:(Card*)card {
    self.primaryText.text = card.engWord;
    self.secondaryText.text = card.swaWord;
}

-(void)setIsEnabled:(BOOL)isEnabled {
    if (_isEnabled != isEnabled){
        _isEnabled = isEnabled;
        self.primaryText.userInteractionEnabled = self.isEnabled;
        self.secondaryText.userInteractionEnabled = self.isEnabled;
    }
}

+(CGFloat)height {
    return 60;
}

@end
