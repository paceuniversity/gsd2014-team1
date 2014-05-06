//
//  Pack.h
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pack : NSObject
@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSUInteger packID;
@property (strong, nonatomic, readonly) NSString *fileName;
@property (strong, nonatomic) NSMutableArray *cards;

-(id)initEmptyPack;
-(id)initWithProperties:(NSDictionary*)properties;
-(NSDictionary*)dictRepresentation;

@end
