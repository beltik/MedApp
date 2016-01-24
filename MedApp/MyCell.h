//
//  MyCell.h
//  MedApp
//
//  Created by Necrosoft on 22/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@end
