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
    self.phraseField.font = FiraLight(17);
    self.translationField.font = FiraLight(17);

    self.phraseField.textColor = jetGray;
    self.translationField.textColor = jetGray;

    NSLog(@"dict cell awake");
    self.phraseField.delegate = self;
    self.translationField.delegate = self;

    NSLog(@"phrase field delegate %@",self.phraseField.delegate);

    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

-(void)setupWithDictEntry:(Card*)card {
    self.phraseField.text = card.phrase;
    self.translationField.text = card.translation;
}

+(CGFloat)height {
    return 75;
}

#pragma mark - UITextField
-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.delegate){
        if (textField == self.phraseField){
            [self.delegate phraseWasEditted:self];
        }
        else {
            [self.delegate translationWasEditted:self];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
