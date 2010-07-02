//
//  InfoViewController.h
//  Rap
//
//  Created by Takahashi, Misato a "Development Department" on 10/06/25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//Protpcol
@protocol InfoViewControllerDelegate
- (void)infoViewControllerDidFinish;
@end

@interface InfoViewController : UIViewController {
	id <InfoViewControllerDelegate> parent;
}

@property (nonatomic, retain) id <InfoViewControllerDelegate> parent;

-(void)close:(id)sender;
-(void)contact:(id)sender;

@end
