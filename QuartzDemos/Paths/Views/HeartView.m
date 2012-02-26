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

#import "HeartView.h"

@implementation HeartView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Move the X-origin to center to simplify
	CGContextTranslateCTM(context, CGRectGetMidX(rect), 0);
	
	// Set up stroke and fill colors
	UIColor *fillColor = [UIColor redColor];
	UIColor *strokeColor = [UIColor colorWithRed:0.800 green:0.000 blue:0.000 alpha:1.000];
	
	CGContextSetLineWidth(context, 3.0f);
	CGContextSetLineJoin(context, kCGLineJoinRound);
	CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
	CGContextSetFillColorWithColor(context, fillColor.CGColor);
	
	// Start and End points
	CGPoint startPoint = {0.0f, 115.0f};
	CGPoint endPoint = {0.0f, 300.0f};
	
	// First control point (top)
	CGPoint cp1 = {75.0f, 15.0f};
	// Second control point (bottom)
	CGPoint cp2 = {220.0f, 130.0f};
	
	// Begin new path and move to starting point
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, startPoint.x, startPoint.y);
	
	// Draw Right Side
	CGContextAddCurveToPoint(context, cp1.x, cp1.y, cp2.x, cp2.y, endPoint.x, endPoint.y);
	// Draw Light Side
	CGContextAddCurveToPoint(context, -cp2.x, cp2.y, -cp1.x, cp1.y, startPoint.x, startPoint.y);
	
	// Close and draw path
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
	
}

@end
