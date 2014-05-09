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
        self.phrase = properties[@"phrase"];
        self.translation = properties[@"translation"];
    }
    return self;
}

-(id)initWithDummyCode:(NSString *)dummy {
    self = [super init];
    if (self){
        self.phrase = [dummy stringByAppendingString:@" (eng)"];
        self.translation = [dummy stringByAppendingString:@" (swa)"];
    }
    return self;
}

-(NSString*)description {
    return [[[self dictRepresentation] description] stringByAppendingString:@"\n"];
}

-(NSDictionary*)dictRepresentation {
    return @{@"phrase":self.phrase,
             @"translation":self.translation};
}

@end
