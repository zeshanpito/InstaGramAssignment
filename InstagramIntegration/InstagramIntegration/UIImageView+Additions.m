//
//  UIImageView+Additions.m
//  InstagramIntegration
//
//  Created by Zeshan Hayder on 04/06/2015.
//  Copyright (c) 2015 PITO. All rights reserved.
//

#import "UIImageView+Additions.h"
@implementation UIImageView (Additions)

- (UIImage *)fetchImageFromWebWithUrl:(NSString *)url
{
    self.sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration];
    
    
    
    return nil;
}

@end
