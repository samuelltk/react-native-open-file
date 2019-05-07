//
//  RNDocumentInteractionController.h
//  RNDocumentInteractionController
//
//  Created by Aaron Greenwald on 7/5/16.
//  Copyright © 2016 Wix.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
@import UIKit;

@interface RNDocumentInteractionController : NSObject <RCTBridgeModule>
@property (nonatomic) UIDocumentInteractionController * FileOpener;
@end
