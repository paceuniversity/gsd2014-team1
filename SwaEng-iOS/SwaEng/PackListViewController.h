//
//  PackListViewController.h
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PackListDestinationVC) {
    FlashcardVC,
    DictionaryVC
};

@interface PackListViewController : UITableViewController <UISearchDisplayDelegate>

@property (strong, nonatomic) NSDictionary *flashcardPacks;
@property (nonatomic) PackListDestinationVC destVC;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addPackBarButton;
@end
