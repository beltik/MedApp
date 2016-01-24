//
//  HTTPClient.m
//  MadApp
//
//  Created by Necrosoft on 18/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import "HTTPClient.h"
#import "AFNetworking.h"

//Главный урл вк
#define MAIN_URL @"http://medsolutions.uxp.ru/api/v1/"


@implementation HTTPClient

// Общий метод для получения данных методом GET


-(void)getNewsWithParameters:(NSDictionary *)parameters completion:(void (^)(id))completion{
    
    // Manager customization
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:MAIN_URL]];
    
    [manager.requestSerializer setValue:@"secret_key" forHTTPHeaderField:@"API-KEY"];
    
    [manager GET:@"news" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        completion(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    
    
    
    
    
}

// Метод для отправки лайка методом ПОСТ

-(void)postDataWithParams: (NSDictionary*)params method:(NSString*) method completion: (void (^) (id response)) completion {
    
    AFHTTPRequestOperationManager  *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:MAIN_URL]];
    
    [manager POST:method parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"likePosted" object:self];

        NSLog(@"Post like success!");
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        NSLog(@"Post like error!");
        
    }];

    
}















@end
