//
//  PackCreationViewController.m
//  SwaEng
//
//  Created by Michael Cornell on 4/22/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "PackCreationViewController.h"
#import "Pack.h"
#import "Card.h"
#import "DictionaryCell.h"
#import "PackUtils.h"

@interface PackCreationViewController ()
@property (strong, nonatomic) Pack *pack;
@end

@implementation PackCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cardsTable.delegate = self;
    self.cardsTable.dataSource = self;
    self.pack = [[Pack alloc] initEmptyPack];

    self.packTitleTextfield.delegate = self;

    UINib *dictCellNib = [UINib nibWithNibName:@"DictionaryCell" bundle:nil];
    [self.cardsTable registerNib:dictCellNib forCellReuseIdentifier:@"DictionaryCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)validatePack {
    BOOL isValid = YES;
    if (self.packTitleTextfield.text.length == 0) {
        isValid = NO;
        self.packTitleTextfield.backgroundColor = [UIColor redColor];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}
- (IBAction)saveAndExit:(id)sender {
    self.pack.name = self.packTitleTextfield.text;
    [PackUtils savePackLocally:self.pack];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select");
    if (indexPath.row == self.pack.cards.count){
        NSLog(@"add new card");
        Card *card = [[Card alloc] initWithDummyCode:@"YOLO"];
        [self.pack.cards addObject:card];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.pack.cards.count-1 inSection:0];
        [self.cardsTable beginUpdates];
        [self.cardsTable insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.cardsTable endUpdates];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == self.pack.cards.count){
        static NSString *reuseIdentifier = @"AddNewCardCell";
        UITableViewCell *addNewCardCell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (addNewCardCell == nil) {
            addNewCardCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
            addNewCardCell.textLabel.text = @"Add New Card";
            addNewCardCell.textLabel.textColor = jetGray;
            addNewCardCell.textLabel.font = FiraLight(17);
            addNewCardCell.textLabel.textAlignment = NSTextAlignmentCenter;
            addNewCardCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return addNewCardCell;
    }
    else {
        static NSString *cellIdentifier = @"DictionaryCell";
        DictionaryCell *cell = (DictionaryCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell setupWithDictEntry:self.pack.cards[indexPath.row]];

        cell.delegate = self;
        cell.tag = indexPath.row;

        cell.phraseField.tag = indexPath.row;
        cell.translationField.tag = indexPath.row;

        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DictionaryCell height];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pack.cards.count+1;
}

#pragma mark - DictCell Delegate

-(void)phraseWasEditted:(DictionaryCell*)cell {
    [(Card*)self.pack.cards[cell.tag] setPhrase:cell.phraseField.text];
}
-(void)translationWasEditted:(DictionaryCell*)cell {
    [(Card*)self.pack.cards[cell.tag] setTranslation:cell.translationField.text];
}

#pragma mark - UITextView Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
