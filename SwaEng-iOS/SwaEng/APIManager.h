//
//  APIManager.h
//  SwaEng
//
//  Created by Michael Cornell on 4/9/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "PackUtils.h"

@interface APIManager : AFHTTPRequestOperationManager
+(instancetype)sharedManager;
-(AFHTTPRequestOperation*)downloadPacksWithBlock:(void(^)(Pack *pack, NSError *error))callback;
-(AFHTTPRequestOperation*)postPack:(Pack*)pack withBlock:(void(^)(NSError *error))callback;

@end
