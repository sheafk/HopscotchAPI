//
//  HopscotchNetworking.h
//  Hopscotch-iOS-Test
//
//  Created by Shea Furey-King on 1/10/17.
//  Copyright © 2017 Samantha John. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HopscotchNeworkingDelegate <NSObject>

    - (void)dataRequestDidFinishLoading:(NSMutableArray *)array;

@end

@interface HopscotchNetworking : NSObject
    @property (weak) id delegate;
    -(void)requestProjectData;
@end
