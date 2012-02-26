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

#import "LinearGradientThreeColorVerticalView.h"
#import "UIColor+Additions.h"

@implementation LinearGradientThreeColorVerticalView

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();

	CGFloat locations[3] = {0.0, 0.5, 1.0};

	UIColor *startColor = [UIColor colorWithRed:0.020 green:1.000 blue:0.341 alpha:1.000];
	UIColor *middleColor = [UIColor colorWithRed:0.024 green:0.620 blue:1.000 alpha:1.000];
	UIColor *endColor = [UIColor colorWithRed:0.863 green:0.020 blue:1.000 alpha:1.000];
	
	const CGFloat *staComps = CGColorGetComponents(startColor.CGColor);
	const CGFloat *midComps = CGColorGetComponents(middleColor.CGColor);
	const CGFloat *endComps = CGColorGetComponents(endColor.CGColor);
	CGFloat components[12] = {
			staComps[0], staComps[1], staComps[2], staComps[3],
			midComps[0], midComps[1], midComps[2], midComps[3],
			endComps[0], endComps[1], endComps[2], endComps[3]
	};

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 3);

	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), 0);
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);

	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);
}

@end
