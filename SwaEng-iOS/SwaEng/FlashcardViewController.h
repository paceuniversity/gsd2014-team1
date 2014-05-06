//
//  FlashcardViewController.h
//  SwaEng
//
//  Created by Michael Cornell on 3/27/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pack.h"
@interface FlashcardViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *flashcardSlider;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) Pack *pack;

@end
