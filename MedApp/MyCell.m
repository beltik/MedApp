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


-(void)prepareForReuse{
    
    // Для избежания подгрузки неверных изображений, когда таблица пытается загрузить 5,15,25 и тд. ячейки которые уже были использованны.
    
      [self.myImageView cancelImageRequestOperation];
}

@end
