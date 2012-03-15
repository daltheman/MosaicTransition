//
//  NSArray+Shuffle.m
//  MosaicTransition
//
//  Created by Danilo Altheman on 3/15/12.
//  Copyright (c) 2012 Quaddro. All rights reserved.
//

#import "NSArray+Shuffle.h"

@implementation NSArray (Shuffle)
-(NSArray *)shuffle {
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.count];
    for (id currentObject in self) {
        NSUInteger randomPosition = arc4random() % (tempArray.count + 1);
        [tempArray insertObject:currentObject atIndex:randomPosition];
    }
    return [NSArray arrayWithArray:tempArray];
}
@end
