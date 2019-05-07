//
//  RNDocumentInteractionController.m
//  RNDocumentInteractionController
//
//  Created by Aaron Greenwald on 7/5/16.
//  Copyright © 2016 Wix.com. All rights reserved.
//

#import "RNDocumentInteractionController.h"
#import <UIKit/UIKit.h>

@implementation RNDocumentInteractionController
    
- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(open: (NSString *)path resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:fileURL.path]) {
        NSError *error = [NSError errorWithDomain:@"File not found" code:404 userInfo:nil];
        reject(@"File not found", @"File not found", error);
        return;
    }
    self.FileOpener = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.FileOpener.delegate = self;
    BOOL canPreview=[self.FileOpener presentPreviewAnimated:YES];
    if(!canPreview){
        UIViewController *ctrl = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        
        BOOL wasOpened = [self.FileOpener presentOpenInMenuFromRect:ctrl.view.bounds inView:ctrl.view animated:YES];
        if(wasOpened){
            resolve(@"other app can open this file");
        }else{
            //dont open this file
            NSError *error = [NSError errorWithDomain:@"Open error" code:500 userInfo:nil];
            reject(@"Open error", @"Open error", error);
        }
    }else{
        resolve(@"can preview");
    }
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller
{
    return [[[[UIApplication sharedApplication] delegate] window] rootViewController];
}


@end

