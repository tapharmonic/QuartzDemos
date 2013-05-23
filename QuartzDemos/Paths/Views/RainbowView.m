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

#import "RainbowView.h"
#import "GraphicsFunctions.h"

@implementation RainbowView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor darkGrayColor];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {

	THDrawBlueSkyGradient(UIGraphicsGetCurrentContext(), rect);

	NSMutableArray *colors = [NSMutableArray array];
	[colors addObject:[UIColor colorWithRed:1.000 green:0.250 blue:0.250 alpha:1.000]]; // red
	[colors addObject:[UIColor colorWithRed:1.000 green:0.708 blue:0.014 alpha:1.000]]; // orange
	[colors addObject:[UIColor colorWithRed:1.000 green:0.997 blue:0.369 alpha:1.000]]; // yellow
	[colors addObject:[UIColor colorWithRed:0.381 green:1.000 blue:0.369 alpha:1.000]]; // green
	[colors addObject:[UIColor colorWithRed:0.374 green:0.369 blue:1.000 alpha:1.000]]; // blue
	[colors addObject:[UIColor colorWithRed:0.514 green:0.283 blue:0.768 alpha:1.000]]; // purple


	CGPoint centerPoint = {160.0, 400};
	CGFloat radius = 350;
	CGFloat lineWidth = 25;

	for (int i = 0; i < colors.count; i++) {

		[colors[i] setFill];

		UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:centerPoint
															radius:radius
														startAngle:0
														  endAngle:M_PI clockwise:NO];

		// "Erase" the inner portion of the outer arc by relying on the non-zero winding rule
		[path appendPath:[UIBezierPath bezierPathWithArcCenter:centerPoint
														radius:radius - lineWidth - 1.0f
													startAngle:M_PI endAngle:0
													 clockwise:YES]];

		[path fill];
		radius -= lineWidth;
	}
}

@end
