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
#import "MyCell.h"
//
//@property (strong, nonatomic) IBOutlet UIScrollView *detailScrollView;
//@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
//@property (weak, nonatomic) IBOutlet UILabel *detailTextLabel;
//@property (weak, nonatomic) IBOutlet UILabel *detailCreatedAtLabel;
//@property (weak, nonatomic) IBOutlet UILabel *detailSourceLabel;



@implementation DetailViewController {
    
    MyCell *cell;
}

-(void)viewDidLoad{
    
    /* Create UI */
    self.detailScrollView.backgroundColor = [UIColor whiteColor];
    
     /* Create ImageView */
    
    self.detailImageView =[[UIImageView alloc] initWithFrame:CGRectMake(10,10,300,300)];
    self.detailImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.detailImageView setImageWithURL:[NSURL URLWithString:@"https://i.ytimg.com/vi/8TJIdPKMwTs/maxresdefault.jpg"]];
    
    [self.detailScrollView addSubview:self.detailImageView];
    
    /* Create detail text label header */
    
    UILabel *detailTextHeaderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 320, 300, 30)];
    detailTextHeaderLabel.text = @"Текст новости:";
    [self.detailScrollView addSubview:detailTextHeaderLabel];
    
   
    /* Create detail text label */

    self.detailTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 360, 300, 60)];
    self.detailTextLabel.text = @"Сиськи письки";
    [self.detailScrollView addSubview:self.detailTextLabel];
    
    /* Create created at text label header */
    
    UILabel *createdAtTextLabelheader = [[UILabel alloc]initWithFrame:CGRectMake(10, 430, 300, 30)];
    createdAtTextLabelheader.text = @"Дата создания:";
    [self.detailScrollView addSubview:createdAtTextLabelheader];
    
    /* Create created at text label */
    
    self.detailCreatedAtLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 470, 300, 30)];
    self.detailCreatedAtLabel.text = @"9 октября";
    [self.detailScrollView addSubview:self.detailCreatedAtLabel];
    
    /* Create source text label header */
    
    UILabel *sourceHeaderTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 510, 300, 30)];
    sourceHeaderTextLabel.text = @"Источник:";
    [self.detailScrollView addSubview:sourceHeaderTextLabel];
    
    /* Create source text label */
    self.detailSourceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 550, 300, 30)];
    sourceHeaderTextLabel.text = @"http://anime.adult.ru";
    [self.detailScrollView addSubview:sourceHeaderTextLabel];
    
    /* Create spotlight text label header */
    
    UILabel *spotlightLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 590, 300, 30)];
    sourceHeaderTextLabel.text = @"Похожие новости:";
    [self.detailScrollView addSubview:spotlightLabel];

    
     self.detailScrollView.contentSize = CGSizeMake(320,790);
}

















#pragma mark - table view delegate



// Высота ячейки

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

// Метод определяющий количество ячеек (соответствует количеству объектов массива objectsArray

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Инициализация ячейки
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
   cell.titleLabel.text = @"Test text";
    
    
    return cell;
}


@end
