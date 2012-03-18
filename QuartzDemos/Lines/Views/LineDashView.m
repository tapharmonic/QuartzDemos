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

#import "LineDashView.h"

#define START_X 30.0f
#define END_X    290.0f

@implementation LineDashView

void drawLabel(NSString *label, NSString *description) {
	[label drawAtPoint:CGPointMake(START_X, -40.0f) withFont:[UIFont boldSystemFontOfSize:17]];
	[description drawAtPoint:CGPointMake(START_X + 60.0f, -40.0f) withFont:[UIFont systemFontOfSize:17]];
}

void drawLine(CGContextRef context) {
	CGContextMoveToPoint(context, START_X, 0);
	CGContextAddLineToPoint(context, END_X, 0);
	CGContextStrokePath(context);
}

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextFillRect(context, rect);

	CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 10.0);

	// Dash pattern
	const CGFloat pattern[] = {10, 5, 20, 5};


	// Solid Black Line - No Dash
	CGContextTranslateCTM(context, 0, 80.0f);
	drawLabel(@"Line 1:", @"No Pattern");
	drawLine(context);


	// 10-on, 5-off
	CGContextTranslateCTM(context, 0, 80.0f);
	drawLabel(@"Line 2:", @"10-on, 5-off");
	CGContextSetLineDash(context, 0, pattern, 2);
	drawLine(context);


	// 10-on, 5-off, 20-on, 5-off
	CGContextTranslateCTM(context, 0, 80.0f);
	drawLabel(@"Line 3:", @"10-on, 5-off, 20-on, 5-off");
	CGContextSetLineDash(context, 0, pattern, 4);
	drawLine(context);

	// 20-on, 5-off, 10-on, 5-off
	CGContextTranslateCTM(context, 0, 80.0f);
	drawLabel(@"Line 4:", @"20-on, 5-off, 10-on, 5-off");
	CGContextSetLineDash(context, 15, pattern, 4);
	drawLine(context);
}

@end
