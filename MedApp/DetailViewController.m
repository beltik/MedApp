//
//  DetailViewController.m
//  MedApp
//
//  Created by Necrosoft on 24/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import "DetailViewController.h"
#import "MedsolutionAPI.h"
#import "UIImageView+AFNetworking.h"
#import "NewsParseer.h"
#import "DetailViewController.h"
#import "UIColor+JPExtras.h"
#import "MyCell.h"

/* Macro that we use for convinience, to get screen width or height */

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@implementation DetailViewController {
    
    /* View that will overlay current new, showing activity indicator while data loading */

    UIView *viewToAdd;
    
    /* Activity indicator */

    UIActivityIndicatorView *indicator;
    
    MyCell *cell;
    
    /* Bool variable, that indicate whether our data is loaded */

    BOOL isDataLoaded;
}

-(void)viewDidLoad{
    
    /* Firstly we show empty view with activity indicator */
    
    [self addActivityIndicatorWithView];

    
    /* Load news and spotlight */

    [self loadDetailNewsAndSpotling];
 
    
;}

/* Loading news and spotlight */

-(void)loadDetailNewsAndSpotling{
    
    
    [[MedsolutionAPI sharedInstance] getNewsDetailWithID:[self detailNewsID] :^(NSMutableArray *dataArray) {
        
        self.detailDataArray = dataArray;
        [self loadingFinished];
    }];
}

#pragma mark - Notification Center

/* We call that method to update UI in main thred when loading is finished */

-(void)loadingFinished{

    
    [self removeActivityIndicatorAndLoadingView];
    
    /* Get UILabel height, depending on its content */
 
    [self adjustTextLabelSize];
    
    /* Add user interface elements programmatically */
    
    [self createUserInterface];
    
    /* Set news text */

    self.detailTextLabel.text = [[self.detailDataArray objectAtIndex:0]valueForKey:@"text"];
    
    /* Set text for createdAt label */
    
    self.detailCreatedAtLabel.text = self.detailCreatedAt;
    
    /* Set text for source label */

    self.detailSourceLabel.text = [[self.detailDataArray objectAtIndex:0]valueForKey:@"source"];
    
    /* Reload table */
    
    isDataLoaded = YES;
    
    [self.spotlightTableView reloadData];
 

}

-(void)viewDidLayoutSubviews {
    
    /* Adjust Y coordinate of table view, depending of content of detailTextLabel */
    
    self.spotlightTableView.frame = CGRectMake(10, 570 + self.detailTextLabel.frame.size.height, 300, 200);
    
}

#pragma mark - UI

/* Adjust text label size (height) depending on text it contain */

-(void)adjustTextLabelSize{
    
    /* Get expected label size */
    
    CGSize maximumLabelSize = CGSizeMake(300, FLT_MAX);
    
    CGSize expectedLabelSize = [[[self.detailDataArray objectAtIndex:0]valueForKey:@"text"] sizeWithFont:[UIFont fontWithName:@"Helvetica Neue" size:15] constrainedToSize:maximumLabelSize lineBreakMode:self.detailTextLabel.lineBreakMode];
    
    
    /* Create detail text label */
    
    self.detailTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 360, 300, expectedLabelSize.height)];
    self.detailTextLabel.numberOfLines = 20;
    self.detailTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    self.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    
    
    [self.detailScrollView addSubview:self.detailTextLabel];
    
    
}

 /* Create UI */

-(void)createUserInterface{
    
    self.detailScrollView.backgroundColor = [UIColor whiteColor];
    
    /* Create ImageView */
    
    self.detailImageView =[[UIImageView alloc] initWithFrame:CGRectMake(10,10,300,300)];
    self.detailImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.detailImageView setImageWithURL:[NSURL URLWithString:self.detailUrlString]];
    
    [self.detailScrollView addSubview:self.detailImageView];
    
    /* Create detail text label header */
    
    UILabel *detailTextHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 320, 300, 30)];
    detailTextHeaderLabel.text = @"Текст новости:";
    detailTextHeaderLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    detailTextHeaderLabel.textAlignment = NSTextAlignmentCenter;

    [self.detailScrollView addSubview:detailTextHeaderLabel];
    
    /* Create created at text label header */
    
    UILabel *createdAtTextLabelheader = [[UILabel alloc]initWithFrame:CGRectMake(10, 370 + self.detailTextLabel.frame.size.height, 300, 30)];
    createdAtTextLabelheader.text = @"Дата создания:";
    createdAtTextLabelheader.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    createdAtTextLabelheader.textAlignment = NSTextAlignmentCenter;
    [self.detailScrollView addSubview:createdAtTextLabelheader];
    
    /* Create created at text label */
    
    self.detailCreatedAtLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 410 + self.detailTextLabel.frame.size.height , 300, 30)];
    self.detailCreatedAtLabel.text = @"9 октября";
    self.detailCreatedAtLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    self.detailCreatedAtLabel.textAlignment = NSTextAlignmentCenter;
    [self.detailScrollView addSubview:self.detailCreatedAtLabel];
    
    /* Create source text label header */
    
    UILabel *sourceHeaderTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 450 + self.detailTextLabel.frame.size.height, 300, 30)];
    sourceHeaderTextLabel.text = @"Источник:";
    sourceHeaderTextLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    sourceHeaderTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.detailScrollView addSubview:sourceHeaderTextLabel];
    
    /* Create source text label */
    
    self.detailSourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 490 + self.detailTextLabel.frame.size.height, 300, 30)];
    self.detailSourceLabel.text = @"http://anime.adult.ru";
    self.detailSourceLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    self.detailSourceLabel.textAlignment = NSTextAlignmentCenter;
    [self.detailScrollView addSubview:self.detailSourceLabel];
    
    /* Create spotlight text label header */
    
    UILabel *spotlightLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 530 + self.detailTextLabel.frame.size.height, 300, 30)];
    spotlightLabel.text = @"Похожие новости:";
    spotlightLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    spotlightLabel.textAlignment = NSTextAlignmentCenter;
    [self.detailScrollView addSubview:spotlightLabel];
    
    /* Set scrollView content size depending of height of others UI elements */
    
    self.detailScrollView.contentSize = CGSizeMake(320,600 + self.detailTextLabel.frame.size.height + self.spotlightTableView.frame.size.height);
    
}

-(void)addActivityIndicatorWithView{
    
    /* Add empty view while data is laoded */
    
    viewToAdd = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewToAdd.backgroundColor = [UIColor colorWithR:159 G:182 B:205 A:1];
    
    self.detailScrollView.scrollEnabled = NO;
    
    [self.detailScrollView addSubview:viewToAdd];
    
    /* Add Activity Indicator */
    
    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
    indicator.center = viewToAdd.center;
    [viewToAdd addSubview:indicator];
    [indicator bringSubviewToFront:viewToAdd];
    [indicator startAnimating];
}

/* Remove loading view after data loading finished */

-(void)removeActivityIndicatorAndLoadingView{
    
    viewToAdd.hidden = YES;
    indicator.hidden = YES;
    self.detailScrollView.scrollEnabled = YES;
    viewToAdd = nil;
    indicator = nil;
}

#pragma mark - table view delegate


/* Cell height */

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

/* Number of section */

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

/* Method that set number of rows in spotlight section (we know there is 2 objects) */

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /* Cell initialization */
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    /* When data loaded we fill cell */
    
    if (isDataLoaded){
    
        [cell.myImageView setImageWithURL:[NSURL URLWithString:[[self.detailDataArray objectAtIndex:indexPath.row +1]valueForKey:@"standardImage"]]];
        cell.titleLabel.text = [[self.detailDataArray objectAtIndex:indexPath.row +1]valueForKey:@"title"];
        cell.dateLabel.text = [[self.detailDataArray objectAtIndex:indexPath.row +1]valueForKey:@"created_at"];
    }
    
    return cell;
}








@end
