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
#import "DetailNewsParseer.h"
#import "AFNetworking.h"
#import <Motis.h>


@interface MedsolutionAPI () {
    
    HTTPClient *httpClient;
}


@end

@implementation MedsolutionAPI


/* Standard singleton realisation, which guarantee that we can get only one unique instance ofsingleton object. In any moment of time only single thread can have access to object initialization. */

+ (MedsolutionAPI*)sharedInstance
{
    
    static MedsolutionAPI *_sharedInstance = nil;
    
    
    static dispatch_once_t oncePredicate;
    
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[MedsolutionAPI alloc] init];
    });
    
    return _sharedInstance;
}

/* Class initialization. We also initialize  instance of HTTPClient class, that responsable for interaction with web services by HTTP requests. */

- (id)init
{
    self = [super init];
    if (self) {
        httpClient = [[HTTPClient alloc] init];

    }
    return self;
}

/* Get news */

-(void)getNewsWithParameters:(NSDictionary *)parameters :(void (^)(NSMutableArray *))completionBlock{
    
    [httpClient getNewsWithParameters:parameters completion:^(id response) {
        
        /* Getting array by specific path in JSON object */
        
        NSArray * array = [response valueForKey:@"data"];
        
        /*  New array for store results */
        
        NSMutableArray *arrayNews = [[NSMutableArray alloc] init];
        
        /*  Cycle for filling array with instance of class NewsParseer */
        
        for (int i = 0; i < array.count; i++) {
            
            /* Response mapping */
            
            NewsParseer *news = [[NewsParseer alloc]init];
            
            /* Using 3rd library method for mapping object values */
            
            [news mts_setValuesForKeysWithDictionary:[array objectAtIndex:i]];
            
            /* Add object to an array */
            
            [arrayNews addObject:news];
            
            /* When we finished with filling array, we send notification through notification center and pass array object by block. */
            
            if ([[array objectAtIndex:i] isEqual:[array lastObject]]){
                
                completionBlock(arrayNews);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateTable" object:self];
            }
            
        }

    }];

    
}

-(void)getNewsDetailWithID:(NSString *)itemID :(void (^)(NSMutableArray *))completionBlock{
    
    [httpClient getDetailOfNewsWithID:itemID completion:^(id response) {
        
        /* Parsing detail of specific news object */
        
        /* New array for storing data */
        
        NSMutableArray *arrayNews = [[NSMutableArray alloc] init];
        
        /* Array, storing data of detailed news. */
        
        NSArray * detailedNews = [response valueForKey:@"data"];
        
        /* Mapping response - object, storing details of specific news */
        
        DetailNewsParseer *detailNews = [DetailNewsParseer new];
        
        [detailNews mts_setValuesForKeysWithDictionary:[detailedNews objectAtIndex:0]];
        
        /* Add current object in array */
       
        [arrayNews addObject:detailNews];
        
        /* Mapping response - arrays, that stored data of spotligh news */
        
        NSArray * spotlightDataArray = [response valueForKey:@"spotlight"];
        
        /* Cycle for filling array of spotlight news by NewsParseer objects */
        
        for (int i=0; i<spotlightDataArray.count; i++) {
            
            NewsParseer *spotlightNews = [NewsParseer new];
            
            [spotlightNews mts_setValuesForKeysWithDictionary:[spotlightDataArray objectAtIndex:i]];
            
            [arrayNews addObject:spotlightNews];
            
            if ([[spotlightDataArray objectAtIndex:i] isEqual:[spotlightDataArray lastObject]]){
                
                /* When we finished, pass data by block */
               
                completionBlock(arrayNews);
              
            }
        }

    }];
}



















@end
