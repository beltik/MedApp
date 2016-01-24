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

// Маппинг ответа с помощью библиотеки. Здесь задается путь в объекте JSON к искомым значениям.

//@property (nonatomic, strong) NSString * id;
//@property (nonatomic, strong) NSString * title;
//@property (nonatomic, strong) NSString * standardImage;
//@property (nonatomic, strong) NSString * description;
//@property (nonatomic, strong) NSString * created_at;
//@property (nonatomic, strong) NSString * thumbnailImage;

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
