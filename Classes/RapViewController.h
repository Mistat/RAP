//
//  RapViewController.h
//  Rap
//
//  Created by Takahashi Misato on 10/05/26.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Lap.h"
#import "RapTimer.h"
#import "InfoViewController.h"

@interface RapViewController : UIViewController<InfoViewControllerDelegate> {
	NSTimer *nsTimer;
	RapTimer *timer;
	
	UILabel	*currentLapTime;
	UILabel *lapCount;
	UILabel	*totalTime;
	UILabel *fastestLap;
	UILabel *fastestLapTime;
	
	UIButton *startStopButton;
	UIButton *lapButton;
	UIButton *clearButton;
	
	UITableView *lapTable;
}

// Labels
@property (nonatomic, retain) IBOutlet UILabel *currentLapTime;
@property (nonatomic, retain) IBOutlet UILabel *fastestLapTime;
@property (nonatomic, retain) IBOutlet UILabel *fastestLap;
@property (nonatomic, retain) IBOutlet UILabel *lapCount;

// Buttons 
@property (nonatomic, retain) IBOutlet UIButton *startStopButton;
@property (nonatomic, retain) IBOutlet UIButton *lapButton;
@property (nonatomic, retain) IBOutlet UIButton *clearButton;

@property (nonatomic, retain) IBOutlet UITableView *lapTable;

 
- (IBAction)startStopCount:(id)sender;
- (IBAction)lapCount:(id)sender;
- (IBAction)clearCount:(id)sender;


- (IBAction)infoView:(id)sender;
- (void)infoViewControllerDidFinish;

- (void)resetView;
- (NSString*) timerFormat:(double)time;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

