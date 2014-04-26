//
//  CameraViewController.m
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/5/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController
@synthesize imageView=_imageView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[[event allTouches] anyObject];
    if([_name isFirstResponder] && [touch view]!=_name){
        [_name resignFirstResponder];
    }else if ([_brand isFirstResponder]&&[touch view]!=_brand){
        [_brand resignFirstResponder];
    }else if ([_describe isFirstResponder]&& [touch view]!=_describe){
        [_describe resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //set imageview;
    _imageView.layer.cornerRadius=8;
    _imageView.layer.masksToBounds=YES;
    _imageView.layer.borderWidth=2;
    _imageView.layer.borderColor=[[UIColor grayColor] CGColor];
    _image.layer.cornerRadius=8;
    _image.frame=_imageView.frame;
    TQStarRatingView *starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)
                                                                  numberOfStar:5];
    starRatingView.delegate = self;
    [self.ratestar addSubview:starRatingView];
    
}
-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    _clothrate.text=[NSString stringWithFormat:@"Cloth rate:%0.2f",(score*5)];
    _ratecons=[NSNumber numberWithFloat:(score*5)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}


#pragma camera;
- (IBAction)takepicture:(id)sender {
    UIActionSheet *photoBtnActionSheet =
    [[UIActionSheet alloc] initWithTitle:nil
                                delegate:self
                       cancelButtonTitle:@"Cancel"
                  destructiveButtonTitle:nil
                       otherButtonTitles:@"Photo Library",@"Take Photo", nil];
    [photoBtnActionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    [photoBtnActionSheet showInView:[self.view window]];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // NSLog(@"Action Sheet Button Index: %d",buttonIndex);
    if (buttonIndex == 0) {
        
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        {
            UIImagePickerController *imagePicker =
            [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker
                               animated:YES completion:nil];
            _newMedia = NO;
        }
    }
    if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker =
            [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
            imagePicker.allowsEditing = NO;
            [self presentViewController:imagePicker
                               animated:YES completion:nil];
            _newMedia = YES;
        }
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
       // UIImage *ima=info[UIImagePickerControllerEditedImage];
        _image.image= image;
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}


#pragma save;
- (IBAction)save:(id)sender {
       if (_image.image!=nil&&![_name.text isEqualToString:@""]) {
        NSLog(@"save");
           NSString *choice=_entitycloth;
           NSManagedObjectContext *moc=[kAppDelegate managedObjectContext];
           NSManagedObject *newCloth=[NSEntityDescription insertNewObjectForEntityForName:@"Clothes" inManagedObjectContext:moc];
           
           NSData *imageSave=UIImageJPEGRepresentation(_image.image, 1.0);

    [newCloth setValue:imageSave forKey:@"image"];
    [newCloth setValue:_name.text forKey:@"name"];
    [newCloth setValue:choice forKey:@"kindOf"];
    [newCloth setValue:_ratecons forKeyPath:@"rate"];
    [newCloth setValue:_describe.text forKeyPath:@"describe"];
     [newCloth setValue:_brand.text forKeyPath:@"brandseries"];
    [newCloth setValue:0 forKeyPath:@"useTime"];
      
    
    NSError *mocSaveError=nil;
    if ([moc save:&mocSaveError]) {
        NSLog(@"Save completed successfully");
        
        [self performSegueWithIdentifier:@"backToMain" sender:self];
    }
    
}
    else if([_describe.text length]>150||[_name.text length]>15){
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"too long describe" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];

    }
    else{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Oops" message:@"lack of photo or name" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];}

}
#pragma keyboard;
-(void) textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"111");
    textView.text=nil;
    CGRect frame = textView.frame;
    int offset = frame.origin.y + 80 - (self.view.frame.size.height - 216.0);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];

}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{   NSLog(@"111");
    textField.text=nil;
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}
@end
