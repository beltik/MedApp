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
    
    short currentIndex;
    NSNumber *currentPage;
    MyCell *cell;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Setting ivars
    
    currentPage = @(1);

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
    
    [[MedsolutionAPI sharedInstance] getNewsWithParameters:self.parameters :^(NSMutableArray *newsArray) {
       
        self.dataArray = newsArray;
    }];
    
}


#pragma mark - table view delegate

// Метод который вызывается при нажатии на ячейку. Используем его для вызова метода performSegueWithIdentifier и сохранения текущего индекса.

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    currentIndex = indexPath.row;
    
    [self performSegueWithIdentifier:@"detail" sender:self];
    
    
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
    
    return [self.dataArray count];;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Инициализация ячейки
    
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Получаем объект по соответствующему индексу
    
    NewsParseer *news = [self.dataArray objectAtIndex:indexPath.row];

    // Заполняем ячейку
    
    cell.titleLabel.text = news.title;
    
    cell.dateLabel.text = news.created_at;
    
    // Загружаем изображение с помощью метода загрузки изображений библиотеки AFNetworking
    
    [cell.myImageView setImageWithURL:[NSURL URLWithString:news.thumbnailImage]];
    
    
    return cell;
}

 // Вызывается когда пользователь скролит вниз, для подгрузки новых ячеек

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSInteger currentOffset = scrollView.contentOffset.y;
    NSInteger maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    if (maximumOffset - currentOffset <= -40) {
        NSLog(@"reload");
        
        // Add task
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            /* Создаем свою группу */
            
            dispatch_group_t myGroup = dispatch_group_create();
            
            /* Реализуем задачи в группе */
            
            dispatch_group_enter(myGroup);
            
            /* Имплементация */
            
            
            currentPage = [NSNumber numberWithInt:[currentPage intValue] + 1];
            
            [[MedsolutionAPI sharedInstance] getNewsWithParameters:self.parameters :^(NSMutableArray *newsArray) {
                
                    [self.dataArray addObjectsFromArray:newsArray];

            }];
            
            dispatch_group_leave(myGroup);
            
            dispatch_group_wait(myGroup, DISPATCH_TIME_FOREVER);
            
            
            
            
        });
  
    }
}

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"detail"])
    {
        // Получаем корректный объект (согласно индексу) и создаем указатель на детальный контроллер
    
        NewsParseer  *news = [self.dataArray objectAtIndex:currentIndex];
        
        // Получаем указатель на контроллер деталей
        
        DetailViewController *detail  = [segue destinationViewController];
        
        // Убираем хтмл тег <br> и заменяем его на \n, что означает переход на новую строку. Передаем значения конкретных переменных и сам объект
        detail.detailCreatedAtLabel.text = news.created_at;
        
    }
}

#pragma mark - setters & getters

-(NSDictionary*)parameters{
    
    return  @{@"page": currentPage, @"limit" : @"5", @"order_by" : @"created_at", @"order":@"desc" };
}














@end
