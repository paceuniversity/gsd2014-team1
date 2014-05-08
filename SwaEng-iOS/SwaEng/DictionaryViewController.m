//
//  DictionaryViewController.m
//  SwaEng
//
//  Created by Michael Cornell on 3/27/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "DictionaryViewController.h"
#import "DictionaryCell.h"
#import "Card.h"

@interface DictionaryViewController ()

@property (strong, nonatomic) NSArray *searchResults;
@end

@implementation DictionaryViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    NSAssert(self.pack,@"Pack must be passed to DictionaryVC");

    UINib *dictCellNib = [UINib nibWithNibName:@"DictionaryCell" bundle:nil];
    [self.tableView registerNib:dictCellNib forCellReuseIdentifier:@"DictionaryCell"];
    [self.searchDisplayController.searchResultsTableView registerNib:dictCellNib forCellReuseIdentifier:@"DictionaryCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

#pragma mark - UISearchViewController

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString
                               scope:self.searchDisplayController.searchBar.scopeButtonTitles[self.searchDisplayController.searchBar.selectedScopeButtonIndex]];
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"phrase beginswith[c] %@", searchText];
    self.searchResults = [self.pack.cards filteredArrayUsingPredicate:resultPredicate];
}

#pragma mark - UITableView Datasource + Delegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"DictionaryCell";
    DictionaryCell *cell = (DictionaryCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.phraseField.userInteractionEnabled = NO;
    cell.translationField.userInteractionEnabled = NO;

    if (tableView == self.searchDisplayController.searchResultsTableView) {
        [cell setupWithDictEntry:self.searchResults[indexPath.row]];

    } else {
        [cell setupWithDictEntry:self.pack.cards[indexPath.row]];
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DictionaryCell height];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
        
    } else {
        return [self.pack.cards count];
    }
}

@end
