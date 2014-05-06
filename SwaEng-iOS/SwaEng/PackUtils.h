//
//  PackUtils.h
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pack.h"
@interface PackUtils : NSObject

// Returns a dict, where the keys are the packFileNames needed by packAtPath, and the values are the pack names
+(NSDictionary*)packsListing;

+(Pack*)packAtPath:(NSString*)packFileName;
+(BOOL)validatePack:(Pack*)pack;
+(BOOL)savePackLocally:(Pack*)pack;
+(BOOL)deletePack:(Pack*)pack;
+(BOOL)deleteAllPacks;

@end
