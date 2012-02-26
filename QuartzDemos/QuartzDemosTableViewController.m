//
//  MIT License
//
//  Copyright (c) 2012 TapHarmonic, LLC http://tapharmonic.com/
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
//  This project was written by Bob McCune http://bobmccune.com for the 
//  February 2012 CocoaHeads MN meeting.  Accompanying slides can be found here:
//

#import "QuartzDemosTableViewController.h"
//#import "HelloQuartzViewController.h"
//#import "SimpleShapesViewController.h"
//#import "CharlieBrownViewController.h"
//#import "GraphPaperViewController.h"
//#import "JoinCapViewController.h"
//#import "LinearGradientViewController.h"
//#import "RadialGradientViewController.h"
//#import "LineDashViewController.h"
//#import "TransformViewController.h"
//#import "FlowerViewController.h"
//#import "RainbowViewController.h"
//#import "FlippedPathsViewController.h"
//#import "HeartViewController.h"
//#import "SmileyViewController.h"
//#import "BeatlesViewController.h"
//#import "AppleMaskViewController.h"
//#import "CocoaHeadsViewController.h"

#import "QuartzDemo.h"
#import "QuartzViewController.h"

@interface UIViewController (Private)
+ (NSString *)displayName;
@end

@interface QuartzDemosTableViewController ()
@property (nonatomic, strong) NSMutableArray *demos;
@end

@implementation QuartzDemosTableViewController

@synthesize demos = _demos;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"Quartz Demos";
	
	self.demos = [NSMutableArray array];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"QuartzDemos" ofType:@"plist"];
	
	for (id data in [NSArray arrayWithContentsOfURL:[NSURL fileURLWithPath:path]]) {
		NSString *group = [[data allKeys] objectAtIndex:0];
		NSMutableArray *quartzDemos = [NSMutableArray array];
		for (NSDictionary *demo in [data objectForKey:group]) {
			NSString *title = [demo valueForKey:@"title"];
			NSString *viewName = [demo valueForKey:@"viewName"];
			[quartzDemos addObject:[QuartzDemo quartzDemoWithTitle:title viewName:viewName]];
		}
		
		[self.demos addObject:[NSDictionary dictionaryWithObject:quartzDemos forKey:group]];
	}

}

#pragma mark -
#pragma mark Table view data source

- (NSArray *)valuesForSection:(NSUInteger)section {
	NSDictionary *dictionary = [self.demos objectAtIndex:section];
	NSString *key = [[dictionary allKeys] objectAtIndex:0];
	return [dictionary objectForKey:key];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[[self.demos objectAtIndex:section] allKeys] objectAtIndex:0];
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.demos count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self valuesForSection:section] count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}


	NSArray *values = [self valuesForSection:indexPath.section];
	cell.textLabel.text = [[values objectAtIndex:indexPath.row] title];

	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray *values = [self valuesForSection:indexPath.section];
	QuartzDemo *demo = [values objectAtIndex:indexPath.row];
	
	id controller = nil;
	if (demo.controllerClass) {
		controller = [[demo.controllerClass alloc] init];
	} else {
		controller = [[QuartzViewController alloc] initWithViewClass:demo.viewClass];
	}
	[controller setTitle:demo.title];
	[self.navigationController pushViewController:controller animated:YES];
}

@end

