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

#import "FlowerView.h"

@implementation FlowerView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor colorWithRed:0.962 green:0.961 blue:0.961 alpha:1.000];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();

	UIColor *stemColor = [UIColor colorWithRed:0.017 green:0.393 blue:0.033 alpha:1.000];
	UIColor *discFillColor = [UIColor colorWithRed:0.996 green:0.781 blue:0.000 alpha:1.000];
	UIColor *discStrokeColor = [UIColor colorWithRed:0.833 green:0.653 blue:0.000 alpha:1.000];
	UIColor *petalFillColor = [UIColor whiteColor];
	UIColor *petalStrokeColor = [UIColor colorWithRed:0.577 green:0.577 blue:0.577 alpha:1.000];

	// Set line styles for strokes
	CGContextSetLineJoin(context, kCGLineJoinRound);
	CGContextSetLineCap(context, kCGLineCapRound);

	CGFloat radius = 50.f;
	CGFloat circleRadians = M_PI * 2;
	CGFloat centerX = rect.size.width / 2;
	CGFloat centerY = rect.size.height / 2;

	// Translate origin to center
	CGContextTranslateCTM(context, centerX, centerY - 50);

	// Draw Stem
	CGContextSetStrokeColorWithColor(context, stemColor.CGColor);
	CGContextSetLineWidth(context, 30);
	CGContextMoveToPoint(context, 0, 40);
	CGContextAddCurveToPoint(context, -50, 125, 50, 125, 0, (rect.size.height / 2) + 50);
	CGContextStrokePath(context);

	// Set stroke and fill colors for disc
	CGContextSetLineWidth(context, 5);
	CGContextSetFillColorWithColor(context, discFillColor.CGColor);
	CGContextSetStrokeColorWithColor(context, discStrokeColor.CGColor);

	// Draw yellow disc
	CGContextBeginPath(context);
	CGContextAddArc(context, 0, 0, radius, 0, circleRadians, YES);
	CGContextDrawPath(context, kCGPathFillStroke);

	// Create reusable path
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL, 0, 55);
	CGPathAddQuadCurveToPoint(path, NULL, -50, 155, 0, 155);
	CGPathAddQuadCurveToPoint(path, NULL, 50, 155, 0, 55);

	// Set smaller line width and set fill/stroke colors
	CGContextSetLineWidth(context, 2);
	CGContextSetFillColorWithColor(context, petalFillColor.CGColor);
	CGContextSetStrokeColorWithColor(context, petalStrokeColor.CGColor);

	NSUInteger numberOfPetals = 12;
	CGFloat rotationAngle = circleRadians / numberOfPetals;

	// Draw Petals
	for (NSUInteger i = 0; i < numberOfPetals; i++) {
		CGContextRotateCTM(context, rotationAngle);
		CGContextAddPath(context, path);
		CGContextDrawPath(context, kCGPathFillStroke);
	}

	CGPathRelease(path);
}

@end
