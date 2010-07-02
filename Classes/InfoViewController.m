//
//  InfoViewController.m
//  Rap
//
//  Created by Takahashi, Misato a "Development Department" on 10/06/25.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InfoViewController.h"


@implementation InfoViewController

@synthesize parent;

-(void)close:(id)sender {
	[parent infoViewControllerDidFinish];
}

-(void)contact:(id)sender {
	
}
						   
						   

@end

