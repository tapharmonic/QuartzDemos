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

#import "FlippedPathsView.h"

@implementation FlippedPathsView

void drawCornerPath(CGContextRef context, CGRect rect, CGColorRef color) {
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, 0, 0);
	CGPathAddLineToPoint(path, NULL, 0, 30);
	CGPathAddLineToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMidY(rect));
	CGPathAddLineToPoint(path, NULL, CGRectGetMidX(rect), 0);
	CGPathCloseSubpath(path);

	CGContextAddPath(context, path);
	CGContextSetLineWidth(context, 1.0);
	CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextSetFillColorWithColor(context, color);
	CGContextDrawPath(context, kCGPathFillStroke);

	CGPathRelease(path);
}

void drawInnerPath(CGContextRef context, CGRect rect, CGColorRef color) {
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 0, 30);
	CGContextAddLineToPoint(context, CGRectGetMidX(rect), CGRectGetMidY(rect));
	CGContextAddLineToPoint(context, 0, CGRectGetMaxY(rect) - 30);
	CGContextClosePath(context);
	CGContextSetLineWidth(context, 1.0);
	CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextSetFillColorWithColor(context, color);
	CGContextDrawPath(context, kCGPathFillStroke);
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();

	CGContextSaveGState(context);
	{
		// top left
		drawCornerPath(context, rect, [UIColor colorWithRed:0.169 green:0.213 blue:0.452 alpha:1.000].CGColor);

		// top right
		CGContextTranslateCTM(context, CGRectGetWidth(rect), 0);
		CGContextScaleCTM(context, -1.0f, 1.0f);
		drawCornerPath(context, rect, [UIColor colorWithRed:0.949 green:0.932 blue:0.539 alpha:1.000].CGColor);

		// bottom right
		CGContextTranslateCTM(context, 0, CGRectGetHeight(rect));
		CGContextScaleCTM(context, 1.0f, -1.0f);
		drawCornerPath(context, rect, [UIColor colorWithRed:0.883 green:0.577 blue:0.252 alpha:1.000].CGColor);

		// bottom left
		CGContextTranslateCTM(context, CGRectGetWidth(rect), 0);
		CGContextScaleCTM(context, -1.0f, 1.0f);
		drawCornerPath(context, rect, [UIColor colorWithRed:0.837 green:0.255 blue:0.072 alpha:1.000].CGColor);
	}
	CGContextRestoreGState(context);

	CGContextSaveGState(context);
	{
		// left inner
		drawInnerPath(context, rect, [UIColor colorWithRed:0.476 green:0.091 blue:0.041 alpha:1.000].CGColor);

		// right inner
		CGContextTranslateCTM(context, CGRectGetWidth(rect), 0);
		CGContextScaleCTM(context, -1.0f, 1.0f);
		drawInnerPath(context, rect, [UIColor colorWithRed:0.332 green:0.535 blue:0.315 alpha:1.000].CGColor);
	}
	CGContextRestoreGState(context);
}

@end
