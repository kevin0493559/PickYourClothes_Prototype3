//
//  SearchInternet.h
//  PickYourClothes
//
//  Created by Rui Yao on 4/6/14.
//  Copyright (c) 2014 HAO GU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchInternet : UIViewController<UIWebViewDelegate>
{
    
     IBOutlet UITextField *textField;
    
    IBOutlet UIWebView *webView;
    UIActivityIndicatorView *activityIndicatorView;
	}

- (IBAction)goBack:(id)sender;
- (IBAction)goForward:(id)sender;
- (IBAction)reLoad:(id)sender;
- (IBAction)stopLoading:(id)sender;

- (IBAction)buttonPress:(id)sender;
- (void)loadWebPageWithString:(NSString*)urlString;

@end
