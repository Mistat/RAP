//
//  Lap.h
//  Rap
//
//  Created by Takahashi, Misato a "Development Department" on 10/06/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Lap : NSObject{
	UInt16 lap;
	double lapTime;
} 

@property UInt16 lap;
@property double lapTime;

@end
