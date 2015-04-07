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

#import "PDFView.h"

@implementation PDFView

- (void)drawRect:(CGRect)rect {

	NSString *path = [[NSBundle mainBundle] pathForResource:@"plato" ofType:@"pdf"];
	NSURL *pdfURL = [NSURL fileURLWithPath:path];

	// Create CGPDFDocumentRef from bundle PDF file
	CGPDFDocumentRef document = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfURL);

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
	CGContextFillRect(context, self.bounds);

	// Flip CTM or PDF content will be upside down
	CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
	CGContextScaleCTM(context, 1.0, -1.0);

	NSUInteger pageCount = CGPDFDocumentGetNumberOfPages(document);
	NSLog(@"%lu pages in Plato's Republic", (unsigned long)pageCount);
	// Get the first page
	CGPDFPageRef page = CGPDFDocumentGetPage(document, 1);

	// Create tranform for PDF content
	CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, self.bounds, 0, true);

	CGContextConcatCTM(context, pdfTransform);

	// Draw the PDF page
	CGContextDrawPDFPage(context, page);

	// Release pdf doc
	CGPDFDocumentRelease(document);

}

@end
