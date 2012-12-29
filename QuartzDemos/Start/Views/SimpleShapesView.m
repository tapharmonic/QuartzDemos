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

#import "SimpleShapesView.h"
#import "GraphicsFunctions.h"

@implementation SimpleShapesView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		//self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

- (void)setStrokeWidth:(CGFloat)value {
	if (self.strokeWidth != value) {
		_strokeWidth = value;
		[self setNeedsDisplay];
	}
}

- (void)drawRect:(CGRect)rect {

	// Get handle to current CGContext
	CGContextRef context = UIGraphicsGetCurrentContext();

	THDrawWhiteGradient(context, rect);

	// Set stroke width and color
	CGContextSetLineWidth(context, self.strokeWidth);
	CGContextSetRGBStrokeColor(context, 0.2f, 0.2f, 0.2f, 1.0f);

	// Draw red square
	CGRect squareRect = CGRectMake(30.0f, 50.0f, 100.0f, 100.0f);
	CGContextSetRGBFillColor(context, 1.0f, 0.0f, 0.0f, 1.0f);
	CGContextFillRect(context, squareRect);
	CGContextStrokeRect(context, squareRect);

	// Draw blue circle
	CGRect circleRect = CGRectMake(180.0f, 50.0f, 100.0f, 100.0f);
	CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
	CGContextFillEllipseInRect(context, circleRect);
	CGContextStrokeEllipseInRect(context, circleRect);

	// Draw green triangle
	CGContextSetFillColor(context, CGColorGetComponents([UIColor greenColor].CGColor));

	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 80.0f, 200);
	CGContextAddLineToPoint(context, 20.0f, 300.f);
	CGContextAddLineToPoint(context, 140.0f, 300.f);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);

	// Draw orange diamond
	CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);

	CGContextBeginPath(context);
	CGContextMoveToPoint(context, 230.0f, 200);
	CGContextAddLineToPoint(context, 190.0f, 250.f);
	CGContextAddLineToPoint(context, 230.0f, 300.f);
	CGContextAddLineToPoint(context, 270.0f, 250.f);
	CGContextClosePath(context);
	CGContextDrawPath(context, kCGPathFillStroke);
}

@end
