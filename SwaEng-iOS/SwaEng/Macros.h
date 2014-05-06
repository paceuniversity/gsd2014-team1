//
//  Macros.h
//  SwaEng
//
//  Created by Michael Cornell on 4/8/14.
//  Copyright (c) 2014 Michael Cornell. All rights reserved.
//

#ifndef SwaEng_Macros_h
#define SwaEng_Macros_h

#define mintGreen      [UIColor colorWithRed:(128/255.0) green:(198/255.0) blue:(111/255.0) alpha:1]
#define ivoryWhite     [UIColor colorWithRed:(250/255.0) green:(248/255.0) blue:(237/255.0) alpha:1]
#define cornflowerBlue [UIColor colorWithRed:( 51/255.0) green:(129/255.0) blue:(226/255.0) alpha:1]
#define jetGray        [UIColor colorWithRed:( 31/255.0) green:( 33/255.0) blue:( 30/255.0) alpha:1]

#define MoonFlower(_size)     [UIFont fontWithName:@"Moon Flower" size:_size]
#define MoonFlowerBold(_size) [UIFont fontWithName:@"Moon Flower Bold" size:_size]
#define FiraLight(_size)      [UIFont fontWithName:@"FiraSansOTLight" size:_size]

#define FORMAT(frmt,...) [NSString stringWithFormat:frmt,__VA_ARGS__]

#endif
