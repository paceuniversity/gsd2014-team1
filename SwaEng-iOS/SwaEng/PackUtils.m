//
//  PackUtils.m
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#import "PackUtils.h"
#import "PListValidation.h"
#import "Card.h"

@implementation PackUtils

+(NSArray*)defaultPacks {
    NSMutableArray *defaultPacks = [NSMutableArray new];
    Pack *dummyPack = [[Pack alloc] init];
    dummyPack.name = @"Dummy Pack";
    dummyPack.packIDString = @"1";
    Card *cardAlpha = [[Card alloc] initWithDummyCode:@"Alpha"];
    Card *cardBeta = [[Card alloc] initWithDummyCode:@"Beta"];
    Card *cardGamma = [[Card alloc] initWithDummyCode:@"Gamma"];
    Card *cardDelta = [[Card alloc] initWithDummyCode:@"Delta"];
    dummyPack.cards = [@[cardAlpha,cardBeta,cardGamma,cardDelta] mutableCopy];
    [defaultPacks addObject:dummyPack];
    return defaultPacks;
}


+(NSString*)swaEngDirectory {
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[[NSBundle mainBundle] bundleIdentifier]];

    BOOL isDir;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    if (!exists) { //isDir shouldn't matter
        NSError *error;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
        if (!success) {
            return nil;
        }
        else {
            for (Pack *pack in [self defaultPacks]){
                [self savePackLocally:pack];
            }
        }
    }
    return path;
}
+(BOOL)deleteAllPacks {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    BOOL allDeletedSuccess = YES;
    for (NSString *file in [fm contentsOfDirectoryAtPath:[self swaEngDirectory] error:&error]) {
        BOOL success = [fm removeItemAtPath:[self expandedPath:file] error:&error];
        if (!success || error) {
            allDeletedSuccess = NO;
        }
    }
    return allDeletedSuccess;
}

+(NSString*)expandedPath:(NSString*)fileName {
    return [[self swaEngDirectory] stringByAppendingPathComponent:fileName];
}

+(NSDictionary*)packsListing {
    NSString *fileName = [[self swaEngDirectory] stringByAppendingPathComponent:@"contents.dict"];
    NSDictionary *contents = [NSDictionary dictionaryWithContentsOfFile:fileName];
    if (contents == nil) {
        contents = [NSDictionary new];
    }
    return contents;
}

+(Pack*)packAtPath:(NSString*)packFileName {
    NSDictionary *packDict = [NSDictionary dictionaryWithContentsOfFile:[self expandedPath:packFileName]];
    Pack *pack = [[Pack alloc] initWithProperties:packDict];
    return pack;
}

+(BOOL)updatePacksListing:(NSDictionary*)newPacksList {
    NSString *fileName = [[self swaEngDirectory] stringByAppendingPathComponent:@"contents.dict"];
    return [newPacksList writeToFile:fileName atomically:YES];
}

+(BOOL)validatePack:(Pack*)pack {
    return (pack.packIDString && pack.name && pack.cards.count > 0 && [NSDictionary validatePList:[pack dictRepresentation]]);
}

+(BOOL)savePackLocally:(Pack*)pack {
    if (![self validatePack:pack]){
        return NO;
    }
    NSDictionary *packsList = [self packsListing];
    Pack *oldPack;

    if (!packsList[pack.fileName]){ // pack doesnt already exist
    }
    else {
        oldPack = [self packAtPath:pack.fileName]; // store the old verison in case of fail
        NSLog(@"got an old pack");
    }

    BOOL writeSuccess = [[pack dictRepresentation] writeToFile:[self expandedPath:pack.fileName] atomically:YES];
    if (writeSuccess) {
        NSMutableDictionary *newPacksList = [packsList mutableCopy];
        newPacksList[pack.fileName] = pack.name;
        BOOL success = [self updatePacksListing:newPacksList];
        if (success){
            return YES;
        }
        else {
            //delete the pack
            [self deletePack:pack];

            if (oldPack) {
                //restore the old version
                [self savePackLocally:oldPack];
            }
            return NO;
        }
    }
    else {
        return NO;
    }
}

+(BOOL)deletePack:(Pack*)pack {
    Pack *oldPack = [self packAtPath:pack.fileName];
    if (!oldPack) {
        // There is no pack by that name to delete
        NSLog(@"Can't delete pack - It appears to not exist");
        return NO;
    }
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtPath:[self expandedPath:pack.fileName] error:&error];
    if (success) {
        NSMutableDictionary *newPacksList = [[self packsListing] mutableCopy];
        [newPacksList removeObjectForKey:pack.fileName];
        BOOL success = [self updatePacksListing:newPacksList];
        if (success){
            return YES;
        }
        else {
            if (oldPack) {
                //restore the old version
                NSLog(@"Restoring pack");
                [self savePackLocally:oldPack];
            }
            return NO;
        }
    }
    else {
        return NO;
    }
}

@end
