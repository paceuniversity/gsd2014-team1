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

@interface PackCreationViewController ()
@property (strong, nonatomic) Pack *pack;
@end

@implementation PackCreationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cardsTable.delegate = self;
    self.cardsTable.dataSource = self;
    self.pack = [[Pack alloc] initEmptyPack];

    UINib *dictCellNib = [UINib nibWithNibName:@"DictionaryCell" bundle:nil];
    [self.cardsTable registerNib:dictCellNib forCellReuseIdentifier:@"DictionaryCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

#pragma mark - UITableView

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
        return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DictionaryCell height];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pack.cards.count+1;
}

#pragma mark - UITextField

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

@end
