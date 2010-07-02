//
//  Timer.m
//  Rap
//
//  Created by Takahashi Misato on 10/05/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RapTimer.h"

@implementation RapTimer

@synthesize lap, fastestLap, lapArray;

-(id)init {
	if ((self = [super init]) == nil) {
		return self;
	}
	lapArray = nil;
	startDate = nil;
	stopDate = nil;
	[self cleanUp];
	return self;
}

// Current time
-(double)current {
	NSTimeInterval current = [startDate timeIntervalSinceNow] * -1 -lastLap;
	NSTimeInterval time = current - offset;
	return time;
}

// Current time
-(double)total {
	NSTimeInterval current = [startDate timeIntervalSinceNow] * -1;
	NSTimeInterval time = current - offset;
	return time;
}


-(void)startCount {
	if (startDate == nil) {
		startDate = [[NSDate date] retain];
	}
	if (stopDate != nil) {
		offset += [stopDate timeIntervalSinceNow] * -1;
	}
}

-(void)pauseCount {
	stopDate = [[NSDate date] retain];
}

-(void)clear {
	[self cleanUp];
}

-(UInt16)doLap {
	double total = [self total];
	double currentLapTime = total - lastLap;
	lastLap = total;
	
	Lap *lapObj = [[Lap alloc] init];
	lapObj.lap = lap;
	lapObj.lapTime = currentLapTime;
	
	if (fastestLap == nil || fastestLap.lapTime > currentLapTime) {
		fastestLap = lapObj;
	}
	
	[lapArray addObject:(id)lapObj];
	
	return ++lap;
}

-(void)cleanUp {
	
	if (startDate != nil) {
		[startDate release];
		startDate = nil;
	}
	if (stopDate != nil) {
		[stopDate release];
		stopDate = nil;
	}
	offset = 0;
	lastLap = 0;
	lap = 0;
	if (lapArray != nil) {
		[lapArray removeAllObjects];
	} else {
		self.lapArray = [NSMutableArray array];
	}
	
	fastestLap = nil;
}

-(void)dealloc {
	[super dealloc];
	[self cleanUp];
	[lapArray release];
}


@end
