//
//  VkontakteAPI.h
//  MadApp
//
//  Created by Necrosoft on 18/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MedsolutionAPI : NSObject

// Объект Синглтон, который используется как основная точка доступа для связи с АПИ.

+ (MedsolutionAPI*)sharedInstance;



-(void)getNewsWithParameters:(NSDictionary*)parameters :(void (^)(NSMutableArray *newsArray)) completionBlock;

@end
