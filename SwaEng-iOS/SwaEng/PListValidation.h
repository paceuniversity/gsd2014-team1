//
//  NSDictionary+PListValidation.h
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (PListValidation)
-(BOOL)isValidPList;
+(BOOL)validatePList:(NSDictionary*)dict;
+(BOOL)validatePList:(NSDictionary*)dict withDepth:(NSUInteger)depth verbose:(BOOL)verbose;
@end

@interface NSArray (PListValidation)
-(BOOL)isValidPList;
+(BOOL)validatePList:(NSArray*)array;
+(BOOL)validatePList:(NSArray*)array withDepth:(NSUInteger)depth verbose:(BOOL)verbose;
@end
