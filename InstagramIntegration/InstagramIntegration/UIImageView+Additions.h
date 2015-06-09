//
//  UIImageView+Additions.h
//  InstagramIntegration
//
//  Created by Zeshan Hayder on 04/06/2015.
//  Copyright (c) 2015 PITO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Additions)

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfiguration;
@property (nonatomic, strong) NSURLSession *session;


- (UIImage *)fetchImageFromWebWithUrl:(NSString *)url;
@end
