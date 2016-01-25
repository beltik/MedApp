//
//  HTTPClient.m
//  MadApp
//
//  Created by Necrosoft on 18/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import "HTTPClient.h"
#import "AFNetworking.h"

/* Main URL */

#define MAIN_URL @"http://medsolutions.uxp.ru/api/v1/"


@implementation HTTPClient

/* Common method for get data using GET method */

-(void)getNewsWithParameters:(NSDictionary *)parameters completion:(void (^)(id))completion{
    
    /* AFHTTPRequestOperationManager customization */
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:MAIN_URL]];
    
    /* Setting HTTP Header value */
    
    [manager.requestSerializer setValue:@"secret_key" forHTTPHeaderField:@"API-KEY"];
    
    /* Main GET method. In case if we succeed, we get response object, in our case JSON data */
    
    [manager GET:@"news" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        completion(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
    
    
}

/*  Getting news detail by ID */

-(void)getDetailOfNewsWithID: (NSString*)itemID  completion:(void (^)(id))completion{
    
    /* Customization of AFHTTPRequestOperationManager */
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:MAIN_URL]];
    
    /* Setting HTTP Header */
    
    [manager.requestSerializer setValue:@"secret_key" forHTTPHeaderField:@"API-KEY"];
    
    /* Main GET method. We set parameters to nil, using itemID for getting specific news */
    
    [manager GET:[NSString stringWithFormat:@"news/%@", itemID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
        completion(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
}















@end
