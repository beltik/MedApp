//
//  HTTPClient.h
//  MadApp
//
//  Created by Necrosoft on 18/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

// Класс ответственный за ХТТП запросы и взаимодействие с сервером

@interface HTTPClient : NSObject

- (void) getDataWithParams: (NSDictionary *) params method:(NSString *) method completion: (void (^) (id response)) completion;

-(void)postDataWithParams: (NSDictionary*)params method:(NSString*) method completion: (void (^) (id response)) completion;


-(void)getNewsWithParameters :(NSDictionary *)parameters completion: (void (^) (id response)) completion;

@end
