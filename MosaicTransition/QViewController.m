//
//  QViewController.m
//  MosaicTransition
//
//  Created by Danilo Altheman on 3/15/12.
//  Copyright (c) 2012 Quaddro. All rights reserved.
//

#import "QViewController.h"
    // Defina o tamanho do mosaico aqui. Ex: 6 x 6 = 36 pedaços =P
#define LINES 7
#define COLUMNS 7

@implementation QViewController
@synthesize mainImageView;
@synthesize positions;

-(void)panGesture:(UIPanGestureRecognizer *)pan {
    [self.view bringSubviewToFront:pan.view];
    CGPoint translation = [pan translationInView:self.view];
    CGPoint position = pan.view.center;
    position.x += translation.x;
    position.y += translation.y;
    pan.view.center = position;
    [pan setTranslation:CGPointZero inView:self.view];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    tempImageView = [[UIImageView alloc] initWithImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    tempImageView.frame = self.view.frame;
    tempImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:tempImageView];
    [picker dismissModalViewControllerAnimated:YES];
    [self generate:self];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        case 1:
            pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            break;
        case 2:
            pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            break;
    }
    [self presentModalViewController:pickerController animated:YES];
}

-(IBAction)selectImage {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Selecione:" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Albuns", @"Biblioteca", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)generate:(id)sender {
    float width = tempImageView.frame.size.width / LINES;
    float height = tempImageView.frame.size.height / COLUMNS;
    
    float startPosX = 0.0;
    float startPosY = 0.0;
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    mainImageView.image = image;
    tempImageView.image = image;
    
    int tag = 1;
    for (int line = 1; line <= LINES; line++) {
        for (int column = 1; column <= COLUMNS; column++) {
            NSLog(@"X = %f, Y = %f", startPosX, startPosY);
            [positions addObject:[NSValue valueWithCGPoint:CGPointMake(startPosX, startPosY)]];
//            UIGraphicsBeginImageContext(CGSizeMake(<#CGFloat width#>, <#CGFloat height#>))
//            CGImageRef imageRef = CGImageCreateWithImageInRect(mainImageView.image.CGImage, CGRectMake(startPosX, startPosY, width, height));
            CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(startPosX, startPosY, width, height));

            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:imageRef]];
            imageView.contentMode = UIViewContentModeScaleToFill;
            imageView.frame = CGRectMake(startPosX, startPosY, width, height);
//            imageView.layer.borderColor = [UIColor blueColor].CGColor;
//            imageView.layer.borderWidth = 2.0;
            imageView.tag = tag;
            imageView.userInteractionEnabled = YES;
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
            [imageView addGestureRecognizer:pan];
            [self.view addSubview:imageView];
            startPosX += width;
            CGImageRelease(imageRef);
        }
        startPosX = 0.0;
        startPosY += height;
        tag++;
    }
    [tempImageView removeFromSuperview];
}

#pragma mark - View lifecycle

-(IBAction)animate {
    NSArray *newPositions = [NSArray arrayWithArray:[positions shuffle]];
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIImageView class]] ) {
                [UIView animateWithDuration:0.25 animations:^{
                    UIImageView *imageView = (UIImageView *)obj;
                    NSValue *positionValue = [newPositions objectAtIndex:idx];
                    CGPoint newPosition = [positionValue CGPointValue];
                    imageView.center = CGPointMake(newPosition.x + 23, newPosition.y + 30);
                }];
        } 
    }];
}

- (void)viewDidLoad {
    positions = [NSMutableArray arrayWithCapacity:(LINES * COLUMNS)];
    pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [self setMainImageView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
