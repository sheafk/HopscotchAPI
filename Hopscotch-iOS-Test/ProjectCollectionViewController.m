//
//  ProjectCollectionViewController.m
//  Hopscotch-iOS-Test
//
//  Created by Shea Furey-King on 1/10/17.
//  Copyright © 2017 Samantha John. All rights reserved.
//

#import "ProjectCollectionViewController.h"
#import "HSConstants.h"
#import "UIFont+Hopscotch.h"
#import "UIColor+Hopscotch.h"
#import "Project.h"
#import "ProjectCollectionViewCell.h"
#import <UIKit/UIKit.h>

@interface ProjectCollectionViewController ()

    @property (nonatomic) HopscotchNetworking *hopscotchNetworking;
    @property (nonatomic) NSMutableArray *projectList;
    
@end

@implementation ProjectCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.hopscotchNetworking = [[HopscotchNetworking alloc]init];
    self.hopscotchNetworking.delegate = self;
    [self.hopscotchNetworking requestProjectData];

}
    
- (void)dataRequestDidFinishLoading:(NSMutableArray *)array {
        self.projectList = array;
        [self.collectionView reloadData];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.projectList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const reuseIdentifier = @"Cell";

    ProjectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Project *project = self.projectList[indexPath.row];
    
    //TODO: Image is not loading. Should find a faster way to load images
    cell.image.image = project.image;
    
    cell.title.text = project.projectName;
    cell.author.text = project.userName;
    
    //Styles should be refactored into another function setStyles etc.
    cell.image.clipsToBounds = YES;
    cell.image.layer.cornerRadius = HSImageCornerRadius;
    cell.image.layer.borderWidth = HSImageBorderWidth;
    cell.image.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor imageBorderColor]);
    [cell.image setFrame:CGRectMake(0, 0, HSImageWidth, HSImageHeight)];
  
    cell.title.font = [UIFont titleFont];
    cell.author.font = [UIFont authorFont];
    cell.title.textColor = [UIColor titleColor];
    cell.author.textColor = [UIColor authorColor];
    
    return cell;
}
    

@end
