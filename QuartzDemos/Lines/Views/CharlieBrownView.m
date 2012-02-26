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

#import "CharlieBrownView.h"

@implementation CharlieBrownView

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Fill background with Yellow
	UIColor *fillColor = [UIColor colorWithRed:0.961 green:0.704 blue:0.159 alpha:1.000];
	CGContextSetFillColorWithColor(context, fillColor.CGColor);
	CGContextFillRect(context, rect);
	
	// Set stroke color and line width
	CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextSetLineWidth(context, 60.0f);
	
	// Translate Y down 190 points
	CGContextTranslateCTM(context, 0.0f, 190.0f);
	
	CGPoint blackLines[] = {
		CGPointMake(-30.0f, 130.0f),
		CGPointMake(45.0f, 30.0f),
		CGPointMake(100.0f, 100.0f),
		CGPointMake(160.0f, 30.0f),
		CGPointMake(220.0f, 100.0f),
		CGPointMake(275.0f, 30.0f),
		CGPointMake(350.0f, 130.0f),
	};
	
	CGContextAddLines(context, blackLines, sizeof(blackLines) / sizeof(blackLines[0]));
	CGContextStrokePath(context);
}

@end
