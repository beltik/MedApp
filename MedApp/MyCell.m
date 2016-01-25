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

/* We call that method to prevent bug, when new cells have old images */

-(void)prepareForReuse{
    
    [self.myImageView cancelImageRequestOperation];
    self.myImageView.image = nil;
}

@end
