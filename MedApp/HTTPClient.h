//
//  HTTPClient.h
//  MadApp
//
//  Created by Necrosoft on 18/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Class responding for sending HTTP requests */

@interface HTTPClient : NSObject

/* Method for getting news */

-(void)getNewsWithParameters :(NSDictionary *)parameters completion: (void (^) (id response)) completion;

/*  Method for getting details */

-(void)getDetailOfNewsWithID: (NSString*)itemID completion : (void (^) (id response)) completion;

@end
