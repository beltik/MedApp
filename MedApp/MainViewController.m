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
#import "MyCell.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    
    short currentIndex;
    MyCell *cell;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    // Центр уведомлений. Подписываемся на уведомления чтобы знать, когда нужно обновить табличку.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNotification:) name:@"updateTable" object:nil];
    
    [self loadNews];
}

-(void)reloadNotification: (NSNotification*) notification{

    NSLog(@"Recieved notify");
    [self.tableView reloadData];
}



-(void)loadNews{
    
    //    page=1&limit=5&order_by=created_at&order=desc
    
    NSDictionary * params = @{@"page": @"1", @"limit" : @"5", @"order_by" : @"created_at", @"order":@"desc" };
    
    [[MedsolutionAPI sharedInstance] getNewsWithParameters:params :^(NSMutableArray *newsArray) {
       
        self.dataArray = newsArray;
    }];
    
}


#pragma mark - table view delegate

// Метод который вызывается при нажатии на ячейку. Используем его для вызова метода performSegueWithIdentifier и сохранения текущего индекса.

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    currentIndex = indexPath.row;
    
   // [self performSegueWithIdentifier:@"detail" sender:self];
    
    
}

// Высота ячейки

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

// Метод определяющий количество ячеек (соответствует количеству объектов массива objectsArray

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Инициализация ячейки
    
    NSLog(@"Call???");
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NewsParseer *news = [self.dataArray objectAtIndex:indexPath.row];
    
    NSLog(@"News? %@", [self.dataArray objectAtIndex:indexPath.row]);
    
    NSLog(@"FUCKK %@", news.title);
    
    cell.textLabel.text = news.title;
    
    cell.dateLabel.text = news.created_at;
    
    // Загружаем изображение с помощью метода загрузки изображений библиотеки AFNetworking
    [cell.myImageView setImageWithURL:[NSURL URLWithString:news.standardImage]];
    
    
    return cell;
}



















@end
