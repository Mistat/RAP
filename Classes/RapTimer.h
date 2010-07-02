//
//  Timer.h
//  Rap
//
//  Created by Takahashi Misato on 10/05/26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lap.h"


@interface RapTimer : NSObject {
	// 時間計測開始時間
	NSDate *startDate;
	// 前回停止時間
	NSDate *stopDate;
	// 周回数
	UInt16 lap;
	// ファステストラップ
	Lap *fastestLap;
	// 
	double lastLap;
	double totalTime;
	double currentTime;
	double offset;
	
	NSMutableArray *lapArray;
	
}

@property UInt16 lap;
@property (nonatomic,retain) NSMutableArray *lapArray;
@property (nonatomic,retain) Lap *fastestLap;

//
-(void)startCount;
-(void)stopCount;
-(void)pauseCount;

//
-(void)clear;

//
-(UInt16)doLap;

// Current time
-(double)current;
-(double)total;


-(void)cleanUp;
@end
