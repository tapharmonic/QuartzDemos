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

#import "RadialGradientShapesView.h"

@implementation RadialGradientShapesView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();

	NSMutableArray *colors = [NSMutableArray arrayWithCapacity:3];
	[colors addObject:(__bridge id)[UIColor yellowColor].CGColor];
	[colors addObject:(__bridge id)[UIColor redColor].CGColor];
	[colors addObject:(__bridge id)[UIColor orangeColor].CGColor];

	CGFloat locations[] = {0.0, 0.5, 1.0};

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
	
	CGPoint startPoint = CGPointMake(100.0f, 100.0f);
	CGPoint endPoint = CGPointMake(200.0f, 200.0f);
	CGContextDrawRadialGradient(context, gradient, startPoint, 75.0f, endPoint, 100.0f, 0);

	// Created them need to release them
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}

@end
