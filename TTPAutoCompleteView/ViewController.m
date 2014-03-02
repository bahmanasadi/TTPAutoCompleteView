//
//  ViewController.m
//  TTPAutoCompleteView
//
//  Created by Bahman on 28/02/2014.
//
//

#import "ViewController.h"
#import "AutoCompleteViewController.h"

@interface ViewController ()

@end

@implementation ViewController {
    AutoCompleteViewController *a;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.textfield.delegate = self;
    a = [AutoCompleteViewController viewBelowToUITextField:self.textfield withAutoCompleteItems:[[NSMutableArray alloc] initWithArray:@[@"Item 1", @"Item 2", @"Item 3"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // [a.autoCompleteItems addObject:@"Test"];
    [a recalculateHeight];
    return YES;
}

@end
