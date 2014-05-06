//
//  Card.m
//  SwaEng
//
//  Created by Michael Cornell on 3/27/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "Card.h"

@implementation Card

-(id)initWithProperties:(NSDictionary*)properties {
    self = [super init];
    if (self){
        self.engWord = properties[@"eng_word"];
        self.swaWord = properties[@"swa_word"];
    }
    return self;
}

-(id)initWithDummyCode:(NSString *)dummy {
    self = [super init];
    if (self){
        self.engWord = [dummy stringByAppendingString:@" (eng)"];
        self.swaWord = [dummy stringByAppendingString:@" (swa)"];
    }
    return self;
}

-(NSString*)description {
    return [[[self dictRepresentation] description] stringByAppendingString:@"\n"];
}

-(NSDictionary*)dictRepresentation {
    return @{@"eng_word":self.engWord,
             @"swa_word":self.swaWord};
}

@end
