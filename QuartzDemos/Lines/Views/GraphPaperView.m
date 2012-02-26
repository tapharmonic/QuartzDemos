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

#import "GraphPaperView.h"

@implementation GraphPaperView

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();

	// Background Color
	UIColor *bgColor = [UIColor colorWithRed:0.996 green:0.969 blue:0.811 alpha:1.000];
	CGContextSetFillColorWithColor(context, bgColor.CGColor);
	CGContextFillRect(context, rect);

	// Line Color
	UIColor *lineColor = [UIColor colorWithRed:0.584 green:0.547 blue:0.411 alpha:1.000];;
	CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
	CGContextSetLineWidth(context, 1.0);

	// Draw Horizontal Lines
	CGFloat gridSize = 20.0f;
	CGFloat linePosition = 0.0;
	while (linePosition < rect.size.height) {
		CGContextBeginPath(context);
		CGContextMoveToPoint(context, 0, linePosition);
		CGContextAddLineToPoint(context, rect.size.width, linePosition);
		CGContextStrokePath(context);
		linePosition += gridSize;
	}

	// Draw Vertical Lines
	linePosition = 0.0f;
	while (linePosition < rect.size.width) {
		CGContextBeginPath(context);
		CGContextMoveToPoint(context, linePosition, 0);
		CGContextAddLineToPoint(context, linePosition, rect.size.height);
		CGContextStrokePath(context);
		linePosition += gridSize;
	}

	// Set line width for shapes
	CGContextSetLineWidth(context, 3);

	// Draw Blue Square
	CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, gridSize * 2, gridSize * 2);
	CGContextAddLineToPoint(context, gridSize * 8, gridSize * 2);
	CGContextAddLineToPoint(context, gridSize * 8, gridSize * 8);
	CGContextAddLineToPoint(context, gridSize * 2, gridSize * 8);
	CGContextClosePath(context);
	CGContextStrokePath(context);

	// Draw Red Triangle
	CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
	CGContextBeginPath(context);

	CGPoint points[] = {
			CGPointMake(gridSize * 9, gridSize * 12),
			CGPointMake(gridSize * 5, gridSize * 18),
			CGPointMake(gridSize * 13, gridSize * 18),
	};
	CGContextBeginPath(context);
	CGContextAddLines(context, points, 3);
	CGContextClosePath(context);
	CGContextStrokePath(context);
}

@end
