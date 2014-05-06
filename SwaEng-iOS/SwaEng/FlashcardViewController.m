//
//  FlashcardViewController.m
//  SwaEng
//
//  Created by Michael Cornell on 3/27/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "FlashcardViewController.h"
#import "FlashcardCell.h"
#import "Card.h"

@interface FlashcardViewController ()

@property (strong, nonatomic) NSMutableDictionary *flippedIndexes;

@end

@implementation FlashcardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    UINib *flashcardNib = [UINib nibWithNibName:@"FlashcardCell" bundle:nil];
    [self.flashcardSlider registerNib:flashcardNib forCellWithReuseIdentifier:@"FlashcardCell"];

    self.flashcardSlider.dataSource = self;
    self.flashcardSlider.delegate = self;
    self.flashcardSlider.pagingEnabled = YES;

    self.flippedIndexes = [NSMutableDictionary new];
    self.flashcardSlider.backgroundColor = mintGreen;

    [self.backButton setTitleColor:cornflowerBlue forState:UIControlStateNormal];
    self.backButton.backgroundColor = ivoryWhite;
    self.backButton.titleLabel.font = FiraLight(17);

}

-(void)viewWillAppear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:YES animated:YES];

    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(BOOL)shouldAutorotate {
    return YES;
}
-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
}
- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

// I'm sorry, this name method sucks. it flips a cell into our dict, but the calling method is responsible for animating the flip
-(FlashcardCell*)flipCell:(id)sender {
    if ([sender isKindOfClass:[UIGestureRecognizer class]]){
        sender = [sender view];
    }
    while (![sender isKindOfClass:[FlashcardCell class]]){
        sender = [sender superview];
        if (sender == nil){
            NSLog(@"error, can't flip cell for non flashcard cell");
            break;
        }
    }
    FlashcardCell *cell = sender;
    NSIndexPath *indexPath = [self.flashcardSlider indexPathForCell:cell];

    if (!self.flippedIndexes[@(indexPath.row)]){
        self.flippedIndexes[@(indexPath.row)] = @YES;
    }
    else {
        [self.flippedIndexes removeObjectForKey:@(indexPath.row)];
    }
    return cell;
}

-(void)flip:(id)sender {
    FlashcardCell *cell = [self flipCell:sender];
    [cell flip];
}

-(void)swipeUp:(id)sender {
    FlashcardCell *cell = [self flipCell:sender];
    [cell flipUp];
}

-(void)swipeDown:(id)sender {
    FlashcardCell *cell = [self flipCell:sender];
    [cell flipDown];
}

#pragma mark - UICollectionView Datasource + delegate + layout

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.pack.cards.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlashcardCell *cell = (FlashcardCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"FlashcardCell" forIndexPath:indexPath];
    Card *card = (Card*)self.pack.cards[indexPath.row];
    [cell setupWithDictEntry:card isAlreadyFlipped:(self.flippedIndexes[@(indexPath.row)] != nil)];

    [cell addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flip:)]];

    UISwipeGestureRecognizer* up = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    up.direction = UISwipeGestureRecognizerDirectionUp;
    [cell addGestureRecognizer:up];

    UISwipeGestureRecognizer* down = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    [cell addGestureRecognizer:down];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [FlashcardCell cellSize];
}

@end
