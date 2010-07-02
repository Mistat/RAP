//
//  RapAppDelegate.h
//  Rap
//
//  Created by Takahashi Misato on 10/05/26.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RapViewController;

@interface RapAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    RapViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet RapViewController *viewController;

@end

