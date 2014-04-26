//
//  EditDetailTableViewController.m
//  PickYourClothesCoreData
//
//  Created by tianxiang zhang on 4/6/14.
//  Copyright (c) 2014 tianxiang zhang. All rights reserved.
//

#import "EditDetailTableViewController.h"
@interface EditDetailTableViewController ()
@property (strong,nonatomic) Clothes *clothedit;
@end

@implementation EditDetailTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)configure
{
    if (self.editclothID) {
        Clothes *cloth = (Clothes *)[kAppDelegate.managedObjectContext
                                     objectWithID:self.editclothID];

        
        _clothedit=cloth;
        _name.text=_clothedit.name;
        _brand.text=_clothedit.brand;
        NSData *image=_clothedit.image;
        _image.image=[UIImage imageWithData:image];
        _textfield.text=_clothedit.description;
        _entity.text=_clothedit.kindOf;
        _clothesrate.text=[NSString stringWithFormat:@"Cloth rate:%0.2f",[_clothedit.rate floatValue]];
        _textfield.text=_clothedit.describe;
       // _color.text=cloth.color;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configure];
    
    self.textfield.layer.borderColor=(__bridge CGColorRef)([UIColor grayColor]);
    self.textfield.layer.borderWidth=10.0;
    
    
    
    
    
        
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
#pragma button

- (IBAction)imageSet:(id)sender {
}
- (IBAction)delete:(id)sender {
}
#pragma prepare segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"imageEdit"]) {
       
        imageEditViewController * editdetailimage=(imageEditViewController *)[segue destinationViewController];
        [editdetailimage setImageView:self.image];
        editdetailimage.cloth=_clothedit;
        [editdetailimage setDelegate:self];
    }
    if ([[segue identifier]isEqualToString:@"editName"]) {
        NameEditViewController *edit=(NameEditViewController *)[segue destinationViewController];
        edit.cloth=_clothedit;
        [edit setDelegate:self];
    }
    if ([[segue identifier] isEqualToString:@"brandseriesedite"]) {
        BrandSeriesViewController *brand=(BrandSeriesViewController *)[segue destinationViewController];
        brand.cloth=_clothedit;
        [brand setDelegate:self];
    }
    if ([[segue identifier] isEqualToString:@"describeEdit"]) {
        DescribeEditViewController *describe=(DescribeEditViewController *)[segue destinationViewController];
        describe.clothes=_clothedit;
        [describe setDelegate:self];
    }
    if ([[segue identifier] isEqualToString:@"viewStar"]) {
        viewStarViewController *ratestar=(viewStarViewController *)[segue destinationViewController];
        ratestar.cloth=_clothedit;
        [ratestar setDelegate:self];
    }
}
#pragma delegate
-(void) changeImage:(NSData *)image
{  NSLog(@"11");
    self.image.image=[UIImage imageWithData:image];
    _clothedit.image=image;
    
}
-(void) editName:(NSString *)nameedited
{
    self.name.text=nameedited;
    _clothedit.name=nameedited;
}
-(void) editBrandSeries:(NSString *)brandseries
{
    self.brandseries.text=brandseries;
    _clothedit.brandseries=brandseries;
}
-(void) editDescirbe:(NSString *)descibeedit
{  self.textfield.text=descibeedit;
    _clothedit.describe=descibeedit;
    
}
- (IBAction)Save:(id)sender {
    NSError *error=nil;
    [kAppDelegate.managedObjectContext save:&error];
    [self.delegate clothesEdit:_clothedit];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void) editCothesrate:(NSNumber *)rate
{
    _clothesrate.text=[NSString stringWithFormat:@"Cloth rate:%0.2f",[rate floatValue]];
    _clothedit.rate=rate;
}
#pragma button
- (IBAction)deleteButton:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Want Change" message:@"make a decision" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
    [alert show];
  
   
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
            
        case 1:
            if (_editclothID!=nil) {
                NSManagedObjectContext *moc=[kAppDelegate managedObjectContext];
                NSManagedObject *object=[kAppDelegate.managedObjectContext objectWithID:self.editclothID];
                [moc deleteObject:object];
                NSError *error=nil;
                [moc save:&error];
                [self.navigationController popToRootViewControllerAnimated:YES];

            }
                        break;
    }
}
- (IBAction)switchlandry:(UISwitch *)sender {
    UISwitch *swith=(UISwitch *)sender;
    BOOL buttonison=[swith isOn];
    if (buttonison) {
        _clothedit.landry=[NSNumber numberWithBool:YES];
        
    }else{
        _clothedit.landry=[NSNumber numberWithBool:NO];
    }
}
@end
