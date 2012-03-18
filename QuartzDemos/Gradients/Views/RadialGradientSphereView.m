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

#import "RadialGradientSphereView.h"

@implementation RadialGradientSphereView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

CGGradientRef CreateGreenGradient() {

	NSMutableArray *colors = [NSMutableArray arrayWithCapacity:3];
	[colors addObject:(__bridge id)[UIColor colorWithRed:0.415 green:0.806 blue:0.445 alpha:1.000].CGColor];
	[colors addObject:(__bridge id)[UIColor colorWithRed:0.359 green:0.697 blue:0.385 alpha:1.000].CGColor];
	[colors addObject:(__bridge id)[UIColor colorWithRed:0.303 green:0.588 blue:0.325 alpha:1.000].CGColor];

	// Define Color Locations
	CGFloat locations[] = {0.0, 0.7, 1.0};

	// Create Gradient
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);

	CGColorSpaceRelease(colorSpace);
	return gradient;
}

CGGradientRef CreateGlossGradient() {
	NSMutableArray *colors = [NSMutableArray arrayWithCapacity:2];
	[colors addObject:(__bridge id)[UIColor colorWithWhite:1.0f alpha:0.3f].CGColor];
	[colors addObject:(__bridge id)[UIColor colorWithWhite:1.0f alpha:0.01f].CGColor];

	// Define Color Locations
	CGFloat locations[] = {0.0, 1.0};

	// Create Gradient
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);

	CGColorSpaceRelease(colorSpace);
	return gradient;

}

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();

	CGFloat midX = CGRectGetMidX(rect);
	CGFloat midY = CGRectGetMidY(rect) - 20; // weight towards top

	// Draw shadow layer
	CGContextAddArc(context, midX, midY, 119.f, 0, M_PI * 2, 1);
	CGContextSetShadowWithColor(context, CGSizeMake(3.0f, 1.0f), 10.0f, [UIColor grayColor].CGColor);
	CGContextFillPath(context);

	// Add a clipping region to smooth edges
	CGContextAddArc(context, midX, midY, 120.f, 0, M_PI * 2, 1);
	CGContextClip(context);

	CGPoint midPoint = CGPointMake(midX, midY);
	CGPoint lightPoint = CGPointMake(midPoint.x * 0.8, midPoint.y * 0.7);

	CGGradientRef gradient = CreateGreenGradient();
	CGContextDrawRadialGradient(context, gradient, lightPoint, 0, midPoint, 121.f, 0);
	CGGradientRelease(gradient);
}

@end
