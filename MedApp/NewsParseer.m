//
//  GroupNewsParseer.m
//  MadApp
//
//  Created by Necrosoft on 18/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import "NewsParseer.h"
#import <Motis.h>

@implementation NewsParseer

/* Response mapping. Here we using method of 3rd library Motis */


+ (NSDictionary*)mts_mapping
{
    return @{@"id": mts_key(itemId),
             @"title": mts_key(title),
             @"image": mts_key(standardImage),
             @"description":mts_key(descriptionOfItem),
             @"created_at":mts_key(created_at),
             @"thumbnail":mts_key(thumbnailImage )
             };
}

@end
