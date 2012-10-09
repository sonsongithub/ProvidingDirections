//
//  MakeCoverageViewController.m
//  PrividingDirections
//
//  Created by sonson on 2012/09/25.
//  Copyright (c) 2012年 sonson. All rights reserved.
//

#import "MakeCoverageViewController.h"

@interface MakeCoverageViewController ()

@end

@implementation MakeCoverageViewController

- (IBAction)pushLong:(id)sender {
	if (sender == self.longPressGestureRecognizer) {
		if (self.longPressGestureRecognizer.state == UIGestureRecognizerStateBegan) {
//			CGPoint longPressPoint = [self.longPressGestureRecognizer locationInView:self.view];
//			[self dropPinAtPoint:longPressPoint];
		}
	}
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
