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
        BOOL prod = NO;
        //NSString *localhost = @"http://192.168.1.125:5000";
        NSString *localhost = @"http://10.0.102.141:5000";

        manager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString: prod ? @"http://www.juliegoat.com" : localhost]];
    });

    return manager;
}

-(AFHTTPRequestOperation*)downloadPacksWithBlock:(void(^)(NSArray *packs, NSError *error))callback{
    return [self GET:@"flashpack"
          parameters:nil
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSArray *json = responseObject;
                 NSMutableArray *packs = [NSMutableArray new];
                 for (NSDictionary *packDict in json){
                     Pack *pack = [[Pack alloc] initWithProperties:packDict];
                     [packs addObject:pack];
                 }
                 callback(packs,nil);
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
    return [self POST:@"flashpack"
          parameters:postDict
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 NSDictionary *json = responseObject;
                 // "success"
                 // "id"
                 pack.packIDString = json[@"_id"];
                 [PackUtils savePackLocally:pack];
                 callback(nil);
             }
             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 callback(error);
             }];
}

@end
