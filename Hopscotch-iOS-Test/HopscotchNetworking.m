//
//  HopscotchNetworking.m
//  Hopscotch-iOS-Test
//
//  Created by Flatiron School on 1/10/17.
//  Copyright © 2017 Samantha John. All rights reserved.
//

#import "HopscotchNetworking.h"
#import "Project.h"

@interface HopscotchNetworking()
    
@property (nonatomic) NSMutableArray *projectList;

@end

@implementation HopscotchNetworking
    
    -(void)requestProjectData {
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        NSString *urlString = [NSString stringWithFormat: @"https://hopscotch-ios-test.herokuapp.com/projects"];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        [request setHTTPMethod:@"GET"];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            // Convert JSON to data
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            
            NSArray *projectArray = [dictionary objectForKey:@"projects"];
            self.projectList = [NSMutableArray new];
            
            // Loop through array of projects
            for (NSDictionary *currentProjectDictionary in projectArray) {
                
                Project *newProject = [[Project alloc] init];
                
                if ([[currentProjectDictionary objectForKey:@"title"] isKindOfClass:[NSString class]]) {
                    
                    newProject.userName = [currentProjectDictionary objectForKey:@"author"];
                    newProject.projectName = [currentProjectDictionary objectForKey:@"title"];
                    
                    NSString *imageString = [currentProjectDictionary objectForKey:@"screenshot_url"];
                    NSLog(@"ImageString: %@", imageString);
                    
                    if ([imageString isKindOfClass:[NSString class]]) {
                        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageString]];
                        newProject.image = [UIImage imageWithData: imageData];
                    }
                    else {
                        newProject.image = [UIImage imageNamed: @"placeholder.png"];
                    }
                    
                    [self.projectList addObject:newProject];
                }
                else {
                    break;
                }
            }

            // After all projects are added to the array
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate dataRequestDidFinishLoading:self.projectList];
                NSLog(@"Project List: %@", self.projectList);
            });
            
        }];
        [dataTask resume];
        
    }

@end
