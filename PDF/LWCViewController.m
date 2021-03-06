//
//  LWCViewController.m
//  PDF
//
//  Created by 李伟超 on 14-11-4.
//  Copyright (c) 2014年 LWC. All rights reserved.
//

#import "LWCViewController.h"
#import "PDFView.h"

@interface LWCViewController () <UIScrollViewDelegate,UIGestureRecognizerDelegate,UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LWCViewController {
    CGPDFDocumentRef pdf;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _webView.scrollView.alwaysBounceHorizontal = NO;
    _webView.scrollView.bouncesZoom = NO;
    [_webView.scrollView setBounces:NO];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"pdf"];
//    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURL *url = [NSURL URLWithString:@"http://192.168.16.118:8888/demo1.pdf"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delegate = self;
    [self.view addGestureRecognizer:doubleTap];

//    CATiledLayer

//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    [self.WebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
/*
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _scrollView.directionalLockEnabled = NO;
    _scrollView.delaysContentTouches = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = self.view.bounds.size;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.maximumZoomScale = 6.f;
    _scrollView.decelerationRate = 0.1f;
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_scrollView];
    
    CGRect frame = self.view.bounds;
    
    PDFView *pdfView = [[PDFView alloc] initWithFrame:frame];
    pdfView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    pdfView.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:pdfView];
 */
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)gesture {
    NSLog(@"double");
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat Ws = _scrollView.frame.size.width - _scrollView.contentInset.left - _scrollView.contentInset.right;
    CGFloat Hs = _scrollView.frame.size.height - _scrollView.contentInset.top - _scrollView.contentInset.bottom;
    CGFloat W = _webView.frame.size.width;
    CGFloat H = _webView.frame.size.height;
    
    
    CGRect rct = _webView.frame;
    rct.origin.x = MAX((Ws-W)/2, 0);
    rct.origin.y = MAX((Hs-H)/2, 0);
    _webView.frame = rct;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _webView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
//    NSLog(@"frame:%@",NSStringFromCGRect(_scrollView.frame));
//    NSLog(@"Size: %@",NSStringFromCGSize(_scrollView.contentSize));
//    NSLog(@"Insets: %@",NSStringFromUIEdgeInsets(_scrollView.contentInset));
//    NSLog(@"webview: %@",NSStringFromCGRect(_webView.frame));
//    NSLog(@"__size: %@",NSStringFromCGSize(_webView.scrollView.contentSize));
//
//    NSLog(@"\n\n\n\n");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"***************%@",NSStringFromCGPoint(scrollView.contentOffset));
//    NSLog(@"***************%@\n\n",NSStringFromCGPoint(_webView.scrollView.contentOffset));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *jsString = @"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '50%'";
    [_webView stringByEvaluatingJavaScriptFromString:jsString];
    
    NSString *jsString2 = [[NSString alloc] initWithFormat:@"document.body.style.zoom=1.5"];
    [_webView stringByEvaluatingJavaScriptFromString:jsString2];
}

@end
