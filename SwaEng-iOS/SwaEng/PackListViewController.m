//
//  FlashcardListViewController.m
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "PackListViewController.h"
#import "PackCell.h"
#import "PackUtils.h"
#import "FlashcardViewController.h"
#import "DictionaryViewController.h"
#import "APIManager.h"
@interface PackListViewController ()

@property (strong, nonatomic) NSArray *searchResults;
@property (strong, nonatomic) NSMutableDictionary *invertedPacksList;
@property (strong, nonatomic) NSMutableArray *flashcardPackNames;

@end

@implementation PackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UINib *miniFlashcardCellNib = [UINib nibWithNibName:@"PackCell" bundle:nil];
    [self.tableView registerNib:miniFlashcardCellNib forCellReuseIdentifier:@"PackCell"];
    [self.searchDisplayController.searchResultsTableView registerNib:miniFlashcardCellNib forCellReuseIdentifier:@"PackCell"];

    self.invertedPacksList = [NSMutableDictionary new];

}
-(void)viewWillAppear:(BOOL)animated {
    NSLog(@"view did appear");
    [self refreshPacks];
}
-(void)refreshPacks {

    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = self.view.center;
    spinner.hidesWhenStopped = YES;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    [[APIManager sharedManager] downloadPacksWithBlock:^(NSArray *packs, NSError *error) {
        if (error){
            NSLog(@"error updating packs %@",error.localizedDescription);
        }
        else {
            NSLog(@"updating packs with latest versions...");
            for (Pack *pack in packs){
                [PackUtils savePackLocally:pack];
            }
        }

        [self.invertedPacksList removeAllObjects];
        NSDictionary *flashcardPacks = [PackUtils packsListing];
        for (NSString *key in flashcardPacks.keyEnumerator) {
            self.invertedPacksList[flashcardPacks[key]] = key;
        }
        self.flashcardPackNames = [self.invertedPacksList.allKeys mutableCopy];
        [self.tableView reloadData];

        [spinner stopAnimating];
        [spinner removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)addNewPack:(id)sender {
    [self performSegueWithIdentifier:@"packList->packCreationSegue" sender:self];
}
#pragma mark - Search Display

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString
                               scope:self.searchDisplayController.searchBar.scopeButtonTitles[self.searchDisplayController.searchBar.selectedScopeButtonIndex]];
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@", searchText];
    self.searchResults = [self.flashcardPackNames filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark - Table view data source + delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *flashcardPackName = self.flashcardPackNames[indexPath.row];
    NSString *flashcardPackFileName = self.invertedPacksList[flashcardPackName];

    NSString *segueID;
    if (self.destVC == DictionaryVC) {
        segueID = @"packList->dictionarySegue";
    }
    else {
        segueID = @"packList->flashcardSegue";
    }
    [self performSegueWithIdentifier:segueID sender:flashcardPackFileName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
    }
    else {
        return self.flashcardPackNames.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PackCell *cell = (PackCell*)[tableView dequeueReusableCellWithIdentifier:@"PackCell" forIndexPath:indexPath];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.packNameLabel.text = self.searchResults[indexPath.row];
    }
    else {
        cell.packNameLabel.text = self.flashcardPackNames[indexPath.row];
    }
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"packList->flashcardSegue"] ||
        [segue.identifier isEqualToString:@"packList->dictionarySegue"]){
        Pack *pack = [PackUtils packAtPath:sender];
        [(FlashcardViewController*)segue.destinationViewController setPack:pack];
    }
}


@end
