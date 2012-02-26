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

#import "SmileyView.h"

@implementation SmileyView

- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Fill background with yellow color
	UIColor *fillColor = [UIColor colorWithRed:1.000 green:0.837 blue:0.000 alpha:1.000];
	CGContextSetFillColorWithColor(context, fillColor.CGColor);
	CGContextFillRect(context, rect);
	
	// Set black fill for remaining drawing operations
	CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	
	// Draw Eyes
	CGContextFillEllipseInRect(context, CGRectMake(100, 100, 30, 40));
	CGContextFillEllipseInRect(context, CGRectMake(190, 100, 30, 40));
	
	// Define start, end, and control points
	CGPoint startPoint = {70.0f, 200.0f};
	CGPoint endPoint = {250.0f, 200.f};
	CGPoint cp = {160.0f, 250.0f};
	
	// Begin a new path to draw mouth
	CGContextBeginPath(context);
	
	// Add quad curve for top part of mouth
	CGContextMoveToPoint(context, startPoint.x, startPoint.y);
	CGContextAddQuadCurveToPoint(context, cp.x, cp.y, endPoint.x, endPoint.y);
	
	// Pull control point y value down.
	// Increasing this value opens his mouth, decreasing it closes it
	cp.y = 350.0f;
	
	// Add quad curve for bottom part of mouth
	CGContextAddQuadCurveToPoint(context, cp.x, cp.y, startPoint.x, startPoint.y);
	CGContextClosePath(context);
	
	// Draw smiley mouth
	CGContextFillPath(context);
}

@end
