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

#import "AbstractGradientViewController.h"

@implementation AbstractGradientViewController

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;

- (id)init {
	self = [super initWithNibName:@"AbstractGradientView" bundle:nil];
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor blackColor];
	
	NSArray *classes = [self viewClasses];
	CGRect viewRect = self.scrollView.frame;
	self.scrollView.contentSize = CGSizeMake(viewRect.size.width * [classes count], viewRect.size.height);
	
	for (Class controllerClass in classes) {
		[self.scrollView addSubview:[[controllerClass alloc] initWithFrame:viewRect]];
		viewRect = CGRectOffset(viewRect, viewRect.size.width, 0);
	}
}

// Must be overridden by subclass
- (NSArray *)viewClasses {
	return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (IBAction)changePage:(id)sender {
	CGSize scrollViewSize = self.scrollView.frame.size;
	CGFloat x = scrollViewSize.width * self.pageControl.currentPage;
	CGFloat y = 0;
	CGRect visibleRect = {{x, y}, scrollViewSize};
    [self.scrollView scrollRectToVisible:visibleRect animated:YES];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	self.pageControl = nil;
	self.scrollView = nil;
}

@end
