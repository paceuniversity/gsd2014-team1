//
//  APIManager.m
//  SwaEng
//
//  Created by Michael Cornell on 4/9/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager
+(instancetype)sharedManager {
    static APIManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APIManager alloc] initWithBaseURL:[NSURL URLWithString:@"www.example.com"]];
    });

    return manager;
}

-(AFHTTPRequestOperation*)downloadPack:(NSString*)packName withBlock:(void(^)(Pack *pack, NSError *error))callback{
    return [self GET:FORMAT(@"endpoint/%@",packName)
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

@end
