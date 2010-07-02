//
//  RapViewController.m
//  Rap
//
//  Created by Takahashi Misato on 10/05/26.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RapViewController.h"


@implementation RapViewController

@synthesize currentLapTime, fastestLapTime, fastestLap;
// Buttons 
@synthesize startStopButton, lapButton, clearButton;

@synthesize lapTable;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	[self resetView];
	[lapButton setEnabled:NO];
	nsTimer = nil;
	timer = [[RapTimer alloc] init];
	lapTable.allowsSelection = NO;
}

-(void) resetView {
	currentLapTime.font = [UIFont fontWithName:@"7barSPBd" size:50.0f];
	fastestLapTime.font = [UIFont fontWithName:@"7barSPBd" size:24.0f];
	totalTime.font		= [UIFont fontWithName:@"7barSPBd" size:24.0f];
	lapCount.font		= [UIFont fontWithName:@"7barSPBd" size:35.0f];
	fastestLap.font		= [UIFont fontWithName:@"7barSPBd" size:15.0f];
	
	currentLapTime.text = @"00:00:00.000";
	fastestLapTime.text = @"--:--:--.---";
	fastestLap.text = @"---";
	totalTime.text = @"00:00:00.000";
	lapCount.text = @"001";
}

static BOOL timeTOHIS(double time, int *hour, int *min, int *sec, int *cent) {
	double _sec;
	*cent = (int)(modf(time, &_sec) * 1000);
	*sec = (int)_sec;
	*min = floor(*sec / 60);
	*hour = floor(*min / 60);
	*min = *min % 60;
	*sec = *sec % 60;
	return YES;
}

- (NSString*) timerFormatHMSC:(double)time {
	int hour, min, sec, cent;
	timeTOHIS(time, &hour, &min, &sec, &cent);
	return [NSString stringWithFormat:@"%02d:%02d:%02d.%03d", hour, min, sec, cent];
}
- (NSString*) timerFormatMSC:(double)time {
	int hour, min, sec, cent;
	timeTOHIS(time, &hour, &min, &sec, &cent);
	return [NSString stringWithFormat:@"%02d:%02d.%03d",min*(hour+1), sec, cent];
}

- (void)updateTime:(NSTimer *)aTimer {
	currentLapTime.text = [[self timerFormatHMSC:[[aTimer userInfo] current]] retain];
	totalTime.text = [[self timerFormatHMSC:[[aTimer userInfo] total]] retain];
}

-(IBAction)startStopCount:(id)sender {
	if (nsTimer == nil) {
		[timer startCount];
		nsTimer 
			= [NSTimer scheduledTimerWithTimeInterval:0.037
											   target:self 
											 selector:@selector(updateTime:) 
											 userInfo:timer
											  repeats:YES];
		[startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
		clearButton.enabled = NO;
		lapButton.enabled = YES;
		lapTable.scrollEnabled = NO;
		
	} else {
		[timer pauseCount];
		[nsTimer invalidate];
		nsTimer = nil;
		[startStopButton setTitle:@"Start" forState:UIControlStateNormal];
		clearButton.enabled = YES;
		lapButton.enabled = NO;
		lapTable.scrollEnabled = YES;
	}
}

-(IBAction)lapCount:(id)sender {
	UInt16 lapC = [timer doLap];
	lapCount.text = [NSString stringWithFormat:@"%03d", lapC+1];
	fastestLapTime.text = [self timerFormatHMSC:timer.fastestLap.lapTime];
	fastestLap.text = [NSString stringWithFormat:@"%03d", timer.fastestLap.lap+1];
	[lapTable reloadData];
}

-(IBAction)clearCount:(id)sender {
	[timer clear];
	[self resetView];
	[lapTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	@synchronized(timer.lapArray) {
		return [timer.lapArray count];
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
	static NSString *rowFormat = @"L:%03d %@ %@%@";
	static NSString *minus = @"-";
	static NSString *plus = @"+";
	BOOL fastest = NO;
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	NSUInteger lapNum = [timer.lapArray count] - indexPath.row;
	Lap *lap = (Lap*)[timer.lapArray objectAtIndex:lapNum-1];
	
	double intervalToFastest = 0;
	if (timer.fastestLap != nil) {
		intervalToFastest = timer.fastestLap.lapTime - lap.lapTime;
	}
	if (intervalToFastest >= 0) {
		fastest = YES;
	}
	
	cell.textLabel.text = 
		[NSString stringWithFormat:rowFormat, 
								lapNum, 
								[self timerFormatHMSC:lap.lapTime],
								intervalToFastest >= 0 ? minus : plus,
								[self timerFormatMSC:intervalToFastest>0?intervalToFastest:intervalToFastest*-1]
		 ];
	//cell.textLabel.font = [UIFont fontWithName:@"7barSPBd" size:20.0f];
	cell.textLabel.textColor = fastest ? [UIColor blueColor] : [UIColor blackColor];
	// Set up the cell...
    return cell;
}


- (IBAction)infoView:(id)sender {
	static NSString *InfoViewIdentifier = @"InfoViewController";
	InfoViewController *infoViewController = [[InfoViewController alloc] initWithNibName:InfoViewIdentifier bundle:[NSBundle mainBundle]];    
	infoViewController.parent = self;
	//画面設定
	infoViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:infoViewController animated:YES];
	
	[infoViewController release];					
}

- (void)infoViewControllerDidFinish {
	[self dismissModalViewControllerAnimated:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[timer release];
    [super dealloc];
}

@end
