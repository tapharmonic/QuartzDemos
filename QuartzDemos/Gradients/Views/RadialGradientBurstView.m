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

#import "RadialGradientBurstView.h"

@implementation RadialGradientBurstView

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();

	CGFloat locations[2] = {0.0, 1.0};

	UIColor *lightPurple = [UIColor colorWithRed:0.897 green:0.822 blue:0.993 alpha:1.000];
	UIColor *darkPurple = [UIColor colorWithRed:0.286 green:0.026 blue:0.622 alpha:1.000];

	NSArray *colors = [NSArray arrayWithObjects:(__bridge id)lightPurple.CGColor, (__bridge id)darkPurple.CGColor, nil];

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);

	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), 200.0f);
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), 250.0f);

	int options = kCGGradientDrawsAfterEndLocation | kCGGradientDrawsBeforeStartLocation;
	CGContextDrawRadialGradient(context, gradient, startPoint, 0.0f, endPoint, 300.0f, options);
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);
}


@end
