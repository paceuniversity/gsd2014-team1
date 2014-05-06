//
//  PackCreationViewController.h
//  SwaEng
//
//  Created by Michael Cornell on 4/22/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PackCreationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *packTitleTextfield;
@property (weak, nonatomic) IBOutlet UITableView *cardsTable;

@end
