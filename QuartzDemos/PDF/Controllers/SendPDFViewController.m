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

#import "SendPDFViewController.h"

#define DOC_TITLE @"PDF Created with Quartz"
#define PDF_PATH [NSString stringWithFormat:@"%@/temp.pdf", NSTemporaryDirectory()]

@implementation SendPDFViewController

@synthesize label = _label;
@synthesize button = _button;

- (id)init {
	self = [super initWithNibName:@"SendPDFView" bundle:nil];
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
#if TARGET_IPHONE_SIMULATOR
	self.button.enabled = NO;
	self.label.text = @"This demo must be run on a device.";
#else
	self.label.text = @"";
#endif
}

- (void)viewDidUnload {
	[super viewDidUnload];
	self.label = nil;
	self.button = nil;
}

- (BOOL)createPDFDocumentAtURL:(NSURL *)url {

	// Bounding rectangle for PDF content
	CGRect mediaBox = CGRectMake(0, 0, 250, 250);

	// PDF metadata.  Visible in Preview -> Tools -> Show Inspector -> General Info Inspector
	NSMutableDictionary *metadata = [NSMutableDictionary dictionary];
	[metadata setObject:@"Quartz" forKey:(id)kCGPDFContextCreator];
	[metadata setObject:DOC_TITLE forKey:(id)kCGPDFContextTitle];
	[metadata setObject:@"Bob McCune" forKey:(id)kCGPDFContextAuthor];
	[metadata setObject:@"Creating a PDF file from an iOS app." forKey:(id)kCGPDFContextSubject];

	// Create a PDF context at the specified URL
	CGContextRef pdfContext = CGPDFContextCreateWithURL((__bridge CFURLRef)url, &mediaBox, (__bridge CFDictionaryRef)metadata);

	if (!pdfContext) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Failure"
															message:@"The PDF context could not be created."
														   delegate:nil cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		[alertView show];
		return NO;
	}

	// Begin a new PDF page
	CGContextBeginPage(pdfContext, &mediaBox);

	CGContextSaveGState(pdfContext);
	{
		// Clip content area to media box dimensions
		CGContextClipToRect(pdfContext, mediaBox);

		UIImage *image = [UIImage imageNamed:@"bobmccune"];
		CGRect imageRect = {{0, 0}, image.size};
		CGContextScaleCTM(pdfContext, 0.5, 0.5);
		CGContextDrawImage(pdfContext, imageRect, image.CGImage);

		// Make the whole media box area a clickable link
		NSURL *linkURL = [NSURL URLWithString:@"http://bobmccune.com"];
		CGPDFContextSetURLForRect(pdfContext, (__bridge CFURLRef)linkURL, mediaBox);

	}
	CGContextRestoreGState(pdfContext);

	// End page and free PDF context
	CGContextEndPage(pdfContext);
	CGContextRelease(pdfContext);

	return YES;
}

- (IBAction)emailPDF:(id)sender {

	NSURL *pdfURL = [NSURL fileURLWithPath:PDF_PATH];

	if ([self createPDFDocumentAtURL:pdfURL] && [MFMailComposeViewController canSendMail]) {
		MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
		controller.mailComposeDelegate = self;
		[controller setSubject:DOC_TITLE];
		[controller setMessageBody:@"Check out this PDF file created in Quartz..." isHTML:NO];
		NSData *pdfData = [NSData dataWithContentsOfURL:pdfURL];
		[controller addAttachmentData:pdfData mimeType:@"application/pdf" fileName:@"quartz.pdf"];
		[self presentModalViewController:controller animated:YES];
	} else {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nein!"
															message:@"The email could not be sent at this time."
														   delegate:nil cancelButtonTitle:@"OK"
												  otherButtonTitles:nil];
		[alertView show];
	}
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
