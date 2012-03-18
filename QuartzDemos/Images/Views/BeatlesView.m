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

#import "BeatlesView.h"
#import "GraphicsFunctions.h"

#define IMG_WIDTH 240.0f
#define IMG_HEIGHT 230.0f

@implementation BeatlesView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor whiteColor];
	}
	return self;
}

void drawImageFrame(CGContextRef context, CGRect imageRect) {
	CGContextSaveGState(context);
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
	CGContextSetShadowWithColor(context, CGSizeMake(2.0f, 2.0f), 8.0f, [UIColor grayColor].CGColor);
	TH_CGContextAddRoundedRect(context, CGRectInset(imageRect, -10.0f, -10.0f), 1.0f);
	CGContextDrawPath(context, kCGPathFill);
	CGContextRestoreGState(context);
}

void drawImage(CGContextRef context, CGRect faceRect, CGPoint destPoint) {
	UIImage *groupImage = [UIImage imageNamed:@"beatles"];
	CGImageRef image = CGImageCreateWithImageInRect(groupImage.CGImage, faceRect);

	// Halve the image width/height so the face images can be scaled down to fit screen
	CGRect imageRect = CGRectMake(destPoint.x, destPoint.y, IMG_WIDTH / 2.0f, IMG_HEIGHT / 2.0f);

	// Draw a shadowed frame around the image
	drawImageFrame(context, imageRect);

	// Draw face image, scaled to the 'imageRect' size
	[[UIImage imageWithCGImage:image] drawInRect:imageRect];

	CGImageRelease(image);
}

CGRect faceRect(CGFloat originX, CGFloat originY) {
	return CGRectMake(originX, originY, IMG_WIDTH, IMG_HEIGHT);
}

CGPoint destPoint(CGFloat pointX, CGFloat pointY) {
	return CGPointMake(pointX, pointY);
}

- (void)drawRect:(CGRect)rect {

	CGContextRef context = UIGraphicsGetCurrentContext();

	THDrawWhiteGradient(context, rect);

	UIImage *logoImage = [UIImage imageNamed:@"beatles_logo"];
	[logoImage drawAtPoint:CGPointMake(100.0f, 180.0f)];

	CGFloat lx = 20.0f, rx = 180.0f, ty = 30.0f, by = 270.0f;

	// Draw John
	drawImage(context, faceRect(800.0f, 40.f), destPoint(lx, ty));

	// Draw Paul
	drawImage(context, faceRect(380.0f, 10.0f), destPoint(rx, ty));

	// Draw George
	drawImage(context, faceRect(50.0f, 40.0f), destPoint(lx, by));

	// Draw Ringo
	drawImage(context, faceRect(1040.0f, 60.0f), destPoint(rx, by));
}

@end
