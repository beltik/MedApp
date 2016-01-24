//
//  MyCell.m
//  MedApp
//
//  Created by Necrosoft on 22/01/16.
//  Copyright © 2016 Necrosoft. All rights reserved.
//

#import "MyCell.h"
#import "UIImageView+AFNetworking.h"


@implementation MyCell

//@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *myImageView;


-(void)prepareForReuse{
    
    // Для избежания подгрузки неверных изображений, когда таблица пытается загрузить ячейки которые уже были использованны.
    
    self.dateLabel = nil;
    self.titleLabel = nil;
    [self.myImageView cancelImageRequestOperation];
    self.myImageView.image = nil;
}

@end
