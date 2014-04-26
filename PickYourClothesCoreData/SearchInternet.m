//
//  SearchInternet.m
//  PickYourClothes
//
//  Created by Rui Yao on 4/6/14.
//  Copyright (c) 2014 HAO GU. All rights reserved.
//

#import "SearchInternet.h"

@interface SearchInternet ()

@end

@implementation SearchInternet

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webView.scalesPageToFit =YES;
    webView.delegate =self;
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithFrame : CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)] ;
    [activityIndicatorView setCenter: self.view.center] ;
    [activityIndicatorView setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhite] ;
    [self.view addSubview : activityIndicatorView] ;
//    [self buttonPress:nil];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goBack:(id)sender {
    [webView goBack];
}

- (IBAction)goForward:(id)sender {
    [webView goForward];
}

- (IBAction)reLoad:(id)sender {
    [webView reload];
}

- (IBAction)stopLoading:(id)sender {
    [webView stopLoading];
}

- (IBAction)buttonPress:(id)sender {
    [textField resignFirstResponder];
    NSString *webString=[[NSString alloc]initWithFormat:@"http://%@",textField.text];
    NSLog(@"%@",webString);
    
    [self loadWebPageWithString:webString];

}
- (void)loadWebPageWithString:(NSString*)urlString
{
    
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating] ;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
   
}

@end
