//
//  DetailNewsParseer.m
//  MedApp
//
//  Created by Necrosoft on 25/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import "DetailNewsParseer.h"
#import <Motis.h>

/* Response mapping. Here we using method of 3rd library Motis */

@implementation DetailNewsParseer

+ (NSDictionary*)mts_mapping
{
    return @{@"id": mts_key(itemId),
             @"lead": mts_key(lead),
             @"source": mts_key(source),
             @"text":mts_key(text)
             };
}

@end
