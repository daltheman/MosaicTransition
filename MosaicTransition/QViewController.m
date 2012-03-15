//
//  QViewController.m
//  MosaicTransition
//
//  Created by Danilo Altheman on 3/15/12.
//  Copyright (c) 2012 Quaddro. All rights reserved.
//

#import "QViewController.h"

@implementation QViewController

#pragma mark - Memory Management // Set to nil all objects that are not in use!
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
