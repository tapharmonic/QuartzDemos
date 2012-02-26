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
//  February 2012 Minnesota CocoaHeads meeting.  Accompanying slides can be found here:
//

#import "UIColor+Additions.h"

CGColorRef THRandomColor() {
	CGFloat red = (arc4random() % 256) / 255.0f;
	CGFloat green = (arc4random() % 256) / 255.0f;
	CGFloat blue = (arc4random() % 256) / 255.0f;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
}

void THDrawWhiteGradient(CGContextRef context, CGRect rect) {
	
	UIColor *whiteColor = [UIColor whiteColor];
	UIColor *lightGrayColor = [UIColor colorWithRed:0.966 green:0.966 blue:0.966 alpha:1.000];
	
	NSArray *colors = [NSArray arrayWithObjects:(__bridge id)whiteColor.CGColor, (__bridge id)lightGrayColor.CGColor, nil];
	
	CGFloat locations[2] = {0.0, 1.0};
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
	
	CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);
}

void THDrawBlueSkyGradient(CGContextRef context, CGRect rect) {
	
	CGFloat locations[2] = {0.0, 1.0};
	
	const CGFloat *s = [UIColor colorWithRed:0.942 green:0.970 blue:1.000 alpha:1.000].colorComponents;
	const CGFloat *e = [UIColor colorWithRed:0.498 green:0.735 blue:1.000 alpha:1.000].colorComponents;
	
	CGFloat components[8] =	{
		s[0], s[1], s[2], 1.0,
		e[0], e[1], e[2], 1.0}
	;
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	size_t num_locations = 2;
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
	
	CGPoint point = CGPointMake(100, 100);
	CGContextDrawRadialGradient(context, gradient, point, 100, point, 500, kCGGradientDrawsBeforeStartLocation);
	
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);
}

void THDrawBlueGradient(CGContextRef context, CGRect rect) {
	CGFloat locations[2] = {0.0, 1.0};
	
	const CGFloat *sc = [UIColor colorWithRed:0.194 green:0.253 blue:0.376 alpha:1.000].colorComponents;
	const CGFloat *sc1 = [UIColor colorWithRed:0.152 green:0.199 blue:0.295 alpha:1.000].colorComponents;
	
	CGFloat components[8] = {
		sc[0], sc[1],sc[2], sc[3],
		sc1[0], sc1[1],sc1[2], sc1[3],
	};
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, 2);
	
	CGPoint startPoint = CGPointMake(160, 250);
	CGFloat radius = 250.0f;
	
	CGContextDrawRadialGradient(context, gradient, startPoint, 0, startPoint, radius, kCGGradientDrawsAfterEndLocation);
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);	
}

void TH_CGContextAddRoundedRect(CGContextRef context, CGRect rect, CGFloat radius) {
	
	CGFloat minX = CGRectGetMinX(rect);
	CGFloat maxX = CGRectGetMaxX(rect);
	CGFloat minY = CGRectGetMinY(rect);
	CGFloat maxY = CGRectGetMaxY(rect);
	
	CGContextMoveToPoint(context, minX + radius, minY);
	
	// CGContextAddArc is not aware of flipped context, so 0 results in clockwise direction
	const int CLOCKWISE = 0;
	CGContextAddArc(context, maxX - radius, minY + radius, radius, 3 * M_PI_2, 0.f, CLOCKWISE);
	CGContextAddArc(context, maxX - radius, maxY - radius, radius, 0.f, M_PI_2, CLOCKWISE);
	CGContextAddArc(context, minX + radius, maxY - radius, radius, M_PI_2, M_PI, CLOCKWISE);
	CGContextAddArc(context, minX + radius, minY + radius, radius, M_PI, 3 * M_PI_2, CLOCKWISE);
	
	CGContextClosePath(context);
}

CGPathRef TH_CGPathCreateRoundedRectWithRect(CGRect rect, CGFloat radius) {
	
	CGFloat minX = CGRectGetMinX(rect);
	CGFloat maxX = CGRectGetMaxX(rect);
	CGFloat minY = CGRectGetMinY(rect);
	CGFloat maxY = CGRectGetMaxY(rect);
	
	CGMutablePathRef path = CGPathCreateMutable();
	
	CGPathMoveToPoint(path, NULL, minX + (radius * 2), minY);
	CGPathAddArcToPoint(path, NULL, maxX, minY, maxX, maxY, radius);
	CGPathAddArcToPoint(path, NULL, maxX, maxY, minX, maxY, radius);
	CGPathAddArcToPoint(path, NULL, minX, maxY, minX, minY, radius);
	CGPathAddArcToPoint(path, NULL, minX, minY, maxX, minY, radius);
	CGPathCloseSubpath(path);
	
	return path;
}
