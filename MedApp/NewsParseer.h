//
//  GroupNewsParseer.h
//  MadApp
//
//  Created by Necrosoft on 18/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

/* Class for mapping jSON response */

@interface NewsParseer : NSObject

@property (nonatomic, strong) NSString * itemId;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * standardImage;
@property (nonatomic, strong) NSString * descriptionOfItem;
@property (nonatomic, strong) NSString * created_at;
@property (nonatomic, strong) NSString * thumbnailImage;

@end
