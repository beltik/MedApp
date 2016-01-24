//
//  VkontakteAPI.m
//  MadApp
//
//  Created by Necrosoft on 18/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import "MedsolutionAPI.h"
#import "HTTPClient.h"
#import "NewsParseer.h"
#import "AFNetworking.h"
#import <Motis.h>


@interface MedsolutionAPI () {
    
    HTTPClient *httpClient;
}


@end

@implementation MedsolutionAPI

// Стандартная реализация синглтона, которая гарантирует, что в один момент времени только один thread сможет иметь доступ к объекту для его инициализации. В памяти будет только один уникальный объект класса VkontakteAPI

+ (MedsolutionAPI*)sharedInstance
{
    
    static MedsolutionAPI *_sharedInstance = nil;
    
    
    static dispatch_once_t oncePredicate;
    
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[MedsolutionAPI alloc] init];
    });
    return _sharedInstance;
}

// Инициализация класса. Мы так же инициализируем класс httpClient, отвечающий за взаимодействие с веб сервисом посредством ХТТП запросов.

- (id)init
{
    self = [super init];
    if (self) {
        
        httpClient = [[HTTPClient alloc] init];
        
       
        
    }
    return self;
}

-(void)getNewsWithParameters:(NSDictionary *)parameters :(void (^)(NSMutableArray *))completionBlock{
    
    [httpClient getNewsWithParameters:parameters completion:^(id response) {
        
        // Путь в JSON
        
        NSArray * array = [response valueForKey:@"data"];
        
        
        // Новый массив для хранения результатов
        
        NSMutableArray *arrayNews = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < array.count; i++) {
            
            // Маппинг ответа
            
            NewsParseer *news = [[NewsParseer alloc]init];
            
            
            [news mts_setValuesForKeysWithDictionary:[array objectAtIndex:i]];
            
            // Добавляем массив
            
            [arrayNews addObject:news];
            
            if ([[array objectAtIndex:i] isEqual:[array lastObject]]){
                
                // Отправляем уведомление о том, что данные получены и можно обновлять таблицу.
                completionBlock(arrayNews);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTable" object:self];
            }
            

        }

    }];

    
    
}




















@end
