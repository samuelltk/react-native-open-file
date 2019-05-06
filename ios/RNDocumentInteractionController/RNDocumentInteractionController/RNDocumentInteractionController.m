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

RCT_EXPORT_METHOD(open: (NSURL *)path resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    UIDocumentInteractionController *interactionController = [UIDocumentInteractionController interactionControllerWithURL:path];
    interactionController.delegate = self;
    BOOL canPreview=[interactionController presentPreviewAnimated:YES];
    if(!canPreview){
        UIViewController *ctrl = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        
        BOOL wasOpened = [interactionController presentOpenInMenuFromRect:ctrl.view.bounds inView:ctrl.view animated:YES];
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

