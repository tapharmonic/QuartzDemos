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

#import "JoinCapView.h"

@implementation JoinCapView

- (id)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];
	if (self) {
		_lineCap = kCGLineCapButt;
		_lineJoin = kCGLineJoinMiter;
	}
	return self;
}

- (void)setLineJoin:(CGLineJoin)lineJoin {
	if (self.lineJoin != lineJoin) {
		_lineJoin = lineJoin;
		[self setNeedsDisplay];
	}
}

- (void)setLineCap:(CGLineCap)lineCap {
	if (self.lineCap != lineCap) {
		_lineCap = lineCap;
		[self setNeedsDisplay];
	}
}

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();

	CGContextSetLineCap(context, self.lineCap);
	CGContextSetLineJoin(context, self.lineJoin);
	CGContextSetLineWidth(context, 20);

	CGContextMoveToPoint(context, 50, 250);
	CGContextAddLineToPoint(context, 160, 150);
	CGContextAddLineToPoint(context, 270, 250);
	CGContextStrokePath(context);
}


@end
