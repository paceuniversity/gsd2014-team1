//
//  DictionaryViewController.h
//  SwaEng
//
//  Created by Michael Cornell on 3/27/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pack.h"

@interface DictionaryViewController : UITableViewController <UISearchDisplayDelegate>
@property (strong, nonatomic) Pack *pack;
@end
