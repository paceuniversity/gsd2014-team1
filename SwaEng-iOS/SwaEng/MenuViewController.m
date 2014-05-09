//
//  MenuViewController.m
//  SwaEng
//
//  Created by Michael Cornell on 3/27/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "MenuViewController.h"
#import "PackListViewController.h"
#import "PackUtils.h"
#import "Card.h"
@interface MenuViewController ()
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flashcardButton.titleLabel.font = FiraLight(17);
    self.dictionaryButton.titleLabel.font = FiraLight(17);

    [self.flashcardButton setTitleColor:cornflowerBlue forState:UIControlStateNormal];
    [self.dictionaryButton setTitleColor:cornflowerBlue forState:UIControlStateNormal];

    [self.flashcardButton sizeToFit];
    [self.dictionaryButton sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)viewFlashcards:(id)sender {
    [self performSegueWithIdentifier:@"menu->packListSegue" sender:@(FlashcardVC)];
}

- (IBAction)viewDictionary:(id)sender {
    [self performSegueWithIdentifier:@"menu->packListSegue" sender:@(DictionaryVC)];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"menu->packListSegue"]){
        [(PackListViewController*)segue.destinationViewController setDestVC:[sender intValue]];
    }
}

@end
