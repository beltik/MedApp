//
//  DetailViewController.h
//  MedApp
//
//  Created by Necrosoft on 24/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsParseer.h"

@interface DetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollView;
@property (nonatomic)  UIImageView *detailImageView;
@property (nonatomic)  UILabel *detailTextLabel;
@property (nonatomic)  UILabel *detailCreatedAtLabel;
@property (nonatomic)  UILabel *detailSourceLabel;

@property (weak, nonatomic) IBOutlet UITableView *spotlightTableView;


@end
