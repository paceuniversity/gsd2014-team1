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
        self.packID = -1;
        self.name = @"New Pack";
    }
    return self;
}
-(id)initWithProperties:(NSDictionary*)properties {
    self = [super init];
    if (self) {
        self.name = properties[@"name"];
        self.packID = [properties[@"id"] intValue];
        self.cards = [NSMutableArray new];
        for (NSDictionary *rawCard in properties[@"cards"]){
            Card *card = [[Card alloc] initWithProperties:rawCard];
            [self.cards addObject:card];
        }
    }
    return self;
}
-(NSString*)fileName {
    return FORMAT(@"%@_%lu.flashpack",self.name,(unsigned long)self.packID);
}
-(NSDictionary*)dictRepresentation {
    NSMutableArray *formattedCards = [NSMutableArray new];
    for (Card *card in self.cards){
        [formattedCards addObject:[card dictRepresentation]];
    }
    return @{@"name":self.name,
             @"id":@(self.packID),
             @"cards":formattedCards};
}
-(NSString*)description {
    return [[[self dictRepresentation] description] stringByAppendingString:@"\n"];
}

@end
