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

#import "AppleMaskView.h"
#import "UIColor+Additions.h"
#import "GraphicsFunctions.h"

@implementation AppleMaskView

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bluejeans"]];
	}
	return self;
}

- (void)drawRect:(CGRect)rect {
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	UIImage *maskImage = [UIImage imageNamed:@"apple_mask"];
	UIImage *colorsImage = [UIImage imageNamed:@"apple_colors"];
	
	CGImageRef maskRef = maskImage.CGImage;
	CGImageRef imageMask = CGImageMaskCreate(CGImageGetWidth(maskRef),
											 CGImageGetHeight(maskRef),
											 CGImageGetBitsPerComponent(maskRef),
											 CGImageGetBitsPerPixel(maskRef),
											 CGImageGetBytesPerRow(maskRef),
											 CGImageGetDataProvider(maskRef), NULL, false);
	
	CGImageRef maskedRef = CGImageCreateWithMask(colorsImage.CGImage, imageMask);
	UIImage *maskedImage = [UIImage imageWithCGImage:maskedRef];

	// Free up CG resources
	CGImageRelease(maskedRef);
	CGImageRelease(imageMask);
	
	CGFloat x = (rect.size.width - maskedImage.size.width) / 2;
	CGFloat y = ((rect.size.height - maskedImage.size.height) / 2) - 10;
	
	CGContextSetShadowWithColor(context, CGSizeMake(1.0f, 1.0f), 10, [UIColor blackColor].CGColor);
	[maskedImage drawAtPoint:CGPointMake(x, y)];
}

@end
