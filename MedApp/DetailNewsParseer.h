//
//  DetailNewsParseer.h
//  MedApp
//
//  Created by Necrosoft on 25/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailNewsParseer : NSObject

/* Class for mapping JSON response of detail news */


@property (nonatomic, strong) NSString * itemId;
@property (nonatomic, strong) NSString * lead;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSString * source;





@end
