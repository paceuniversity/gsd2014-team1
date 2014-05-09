//
//  Pack.m
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "Pack.h"
#import "Card.h"

@implementation Pack
-(id)initEmptyPack {
    self = [super init];
    if (self) {
        self.cards = [NSMutableArray new];
        self.packIDString = @"0";
        self.name = @"New Pack";
    }
    return self;
}
-(id)initWithProperties:(NSDictionary*)properties {
    self = [super init];
    if (self) {
        self.name = properties[@"name"];
        self.packIDString = properties[@"_id"];
        self.cards = [NSMutableArray new];
        for (NSDictionary *rawCard in properties[@"cards"]){
            Card *card = [[Card alloc] initWithProperties:rawCard];
            [self.cards addObject:card];
        }
    }
    return self;
}
-(NSString*)fileName {
    return FORMAT(@"%@_%@.flashpack",self.name,self.packIDString);
}
-(NSDictionary*)dictRepresentation {
    NSMutableArray *formattedCards = [NSMutableArray new];
    for (Card *card in self.cards){
        [formattedCards addObject:[card dictRepresentation]];
    }
    return @{@"name":self.name,
             @"_id":self.packIDString,
             @"cards":formattedCards};
}
-(NSString*)description {
    return [[[self dictRepresentation] description] stringByAppendingString:@"\n"];
}

@end
