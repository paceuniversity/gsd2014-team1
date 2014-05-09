//
//  Card.h
//  SwaEng
//
//  Created by Michael Cornell on 3/27/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *phrase;
@property (strong, nonatomic) NSString *translation;

-(id)initWithProperties:(NSDictionary*)json;
-(id)initWithDummyCode:(NSString*)ugu;
-(NSDictionary*)dictRepresentation;


@end
