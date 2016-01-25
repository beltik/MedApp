//
//  VkontakteAPI.h
//  MadApp
//
//  Created by Necrosoft on 18/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedsolutionAPI : NSObject

 /*  Singleton object, responsible for interact with web service API */

+ (MedsolutionAPI*)sharedInstance;

 /* Getting news */

-(void)getNewsWithParameters:(NSDictionary *)parameters :(void (^)(NSMutableArray *newsArray)) completionBlock;

/* Get detail of news with specific ID */


-(void)getNewsDetailWithID:(NSString *)itemID :(void (^)(NSMutableArray *dataArray)) completionBlock;

@end
