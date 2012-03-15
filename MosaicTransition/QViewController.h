//  QViewController.h
//  MosaicTransition
//
//  Created by Danilo Altheman on 3/15/12.
//  Copyright (c) 2012 Quaddro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NSArray+Shuffle.h"

@interface QViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate> {
    UIImagePickerController *pickerController;
    UIImageView *tempImageView;
}

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (strong, nonatomic) NSMutableArray *positions;

- (IBAction)generate:(id)sender;
-(void)panGesture:(UIPanGestureRecognizer *)pan;
-(IBAction)animate;
-(IBAction)selectImage;
@end
