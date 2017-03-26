//
//  ProjectCollectionViewCell.h
//  Hopscotch-iOS-Test
//
//  Created by Shea Furey-King on 1/10/17.
//  Copyright © 2017 Samantha John. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSConstants.h"

@interface ProjectCollectionViewCell : UICollectionViewCell

    @property (strong, nonatomic) IBOutlet UILabel *title;
    @property (strong, nonatomic) IBOutlet UILabel *author;
    @property (weak) IBOutlet UIImageView *image;
    
    
@end
