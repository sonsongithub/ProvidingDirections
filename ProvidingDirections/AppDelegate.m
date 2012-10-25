//
//  AppDelegate.m
//  ProvidingDirections
//
//  Created by sonson on 2012/10/09.
//  Copyright (c) 2012年 sonson. All rights reserved.
//

#import "AppDelegate.h"

#import <MapKit/MapKit.h>

#import "MakeCoverageViewController.h"
#import "RouteViewController.h"

@implementation AppDelegate

- (void)loadRouteViewControllerWithDirectionsRequest:(MKDirectionsRequest*)request {
	UINavigationController *rootNavigationController = (UINavigationController*)self.window.rootViewController;
	if ([[rootNavigationController visibleViewController] isKindOfClass:[MakeCoverageViewController class]]) {
		RouteViewController *vc = (RouteViewController*)[rootNavigationController.storyboard instantiateViewControllerWithIdentifier:@"RouteViewController"];
		vc.request = request;
		[rootNavigationController pushViewController:vc animated:NO];
	}
	else if ([[rootNavigationController visibleViewController] isKindOfClass:[RouteViewController class]]) {
		RouteViewController *vc = (RouteViewController*)[rootNavigationController visibleViewController];
		vc.request = request;
		[vc reload];
	}
}

- (BOOL)application:(UIApplication *)application
			openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
		 annotation:(id)annotation {
	if ([MKDirectionsRequest isDirectionsRequestURL:url]) {
		NSLog(@"Source URL = %@", url);
		MKDirectionsRequest* request= [[MKDirectionsRequest alloc] initWithContentsOfURL:url];
		[self loadRouteViewControllerWithDirectionsRequest:request];
		return YES;
	}
	else {
		// Handle other URL types...
	}
    return NO;
}

@end
