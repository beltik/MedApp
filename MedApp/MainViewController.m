//
//  MainViewController.m
//  MedApp
//
//  Created by Necrosoft on 22/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import "MainViewController.h"
#import "MedsolutionAPI.h"
#import "UIImageView+AFNetworking.h"
#import "NewsParseer.h"
#import "DetailViewController.h"
#import "MyCell.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    
    /* Short value, holding value of current index */

    short currentIndex;
    
    /* Variable, that holding data of current page - parameter, that we pass in GET method, to get information of specific page. We can use it to upload new pages by scrolling to bottom of table view */

    NSNumber *currentPage;
    
    /* Reference to custom cell class */
    
    MyCell *cell;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    /* Firstly we load news for first page. Lately we increment that value, to upload new pages and more news */
    
    currentPage = @(1);

    /* Notification center. We subscribe to notifications to reload table view when we got data from web. Without data we have nothing to display */
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNotification:) name:@"updateTable" object:nil];
    
    /* Loading news */
    
    [self loadNews];
}

/* When we have notification we force our table view to reload itself with new data */

-(void)reloadNotification: (NSNotification*) notification{

    NSLog(@"Recieved notify");
    [self.tableView reloadData];
}

/* Load news. After we got array object using block, we set our local property dataArray to new array */

-(void)loadNews{
    
    [[MedsolutionAPI sharedInstance] getNewsWithParameters:self.parameters :^(NSMutableArray *newsArray) {
       
        self.dataArray = newsArray;
    }];
    
}


#pragma mark - table view delegate

/*  Method called when user tap on a row. We use currentIndex variable to get information of current row. We use it later in prepareForSegue method, to identify correct object that correspond to that row */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /* Saving current index of row */
    
    currentIndex = indexPath.row;
    
    [self performSegueWithIdentifier:@"detail" sender:self];
    
    
}

/* Cell height */

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

/* Method that set number of rows in table, using number of object in property - dataArray */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataArray count];;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /* Initialization of cell */
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    /* Get correct object by index */
    
    NewsParseer *news = [self.dataArray objectAtIndex:indexPath.row];

    /* Fill cell */
    
    cell.titleLabel.text = news.title;
    
    cell.dateLabel.text = news.created_at;
    
    /* Load image with AFNetworking method setImageWithURL */
    
    [cell.myImageView setImageWithURL:[NSURL URLWithString:news.thumbnailImage]];
    
    
    return cell;
}

 /* Call that method when user scroll to bottom of view, to load more news */

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    if (maximumOffset - currentOffset <= -40) {
        
            /* We use taht simple check to identify, where we we have more pages, or we is on the last page. If result of multiplying current page value and 5 (limit of news per page) more then actual news, we return (if expression of multiply higher then dataArrays.count we have no more pages with news, and there is no reason to continue) */
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                
                if ([currentPage intValue] * 5 > self.dataArray.count)
                {
                    NSLog(@"Moar");
                    return;
                }
                
            });
        
        /* We get in one of 3 global queues for create dispatch group. We use groups to increment current page value, and load more news. The reason we use dispatch groups is - if user try to scroll bottom many times, we could not load so much requests at single moment of time, and also we dont want to increment current page value many times */
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            /* Creating dispatch group */
            
            dispatch_group_t myGroup = dispatch_group_create();
            
            /* Enter our group */
            
            dispatch_group_enter(myGroup);
            
            /* Implementation. We increment currentPage value to get news from next page */
            
            currentPage = [NSNumber numberWithInt:[currentPage intValue] + 1];
            
            /* Load next page news */
            
            [[MedsolutionAPI sharedInstance] getNewsWithParameters:self.parameters :^(NSMutableArray *newsArray) {
                
                    [self.dataArray addObjectsFromArray:newsArray];

            }];
            
            dispatch_group_leave(myGroup);
            
            /* We waiting until code is executed. Until then, even if user scroll bottom, our block of code will not be executed */
            
            dispatch_group_wait(myGroup, DISPATCH_TIME_FOREVER);
            
        });
  
    }
}

#pragma mark - segue

/* Method, in which we pass values to next controller, using segue identifier, which we set in Storyboard */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"detail"])
    {
        /* Get correct object (using index) */
    
        NewsParseer  *news = [self.dataArray objectAtIndex:currentIndex];
        
        /* Get reference to next controller*/
        
        DetailViewController *detail  = [segue destinationViewController];
        
        /* Pass variables values */
        
        detail.detailUrlString = news.standardImage;
        detail.detailCreatedAt = news.created_at;
        detail.detailNewsID = news.itemId;
        
    }
}

#pragma mark - setters & getters

/* Getter method for dictionary parameters, that we use in parameters of HTTP request */

-(NSDictionary*)parameters{
    
    return  @{@"page": currentPage, @"limit" : @"5", @"order_by" : @"created_at", @"order":@"desc" };
}














@end
