//
//  APIManager.m
//  SwaEng
//
//  Created by Michael Cornell on 4/9/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "APIManager.h"
#import "Card.h"

@implementation APIManager
+(instancetype)sharedManager {
    static APIManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:@"www.juliegoat.com"]];
    });

    return manager;
}

-(AFHTTPRequestOperation*)downloadPacksWithBlock:(void(^)(Pack *pack, NSError *error))callback{
    return [self GET:@"flashpacks"
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSDictionary *json = responseObject;
                 Pack *pack = [[Pack alloc] initWithProperties:json];
                 callback(pack,nil);
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 callback(nil,error);
             }];
}

-(AFHTTPRequestOperation*)postPack:(Pack *)pack withBlock:(void (^)(NSError *))callback {
    NSMutableArray *formattedCards = [NSMutableArray new];
    for (Card *card in pack.cards){
        [formattedCards addObject:[card dictRepresentation]];
    }
    NSDictionary *postDict = @{@"name":pack.name,
                               @"cards":formattedCards};
    return [self POST:@"flashpacks"
          parameters:postDict
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSDictionary *json = responseObject;
                 callback(nil);
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 callback(error);
             }];
}

@end
