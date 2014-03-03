//
//  AutoCompleteViewController.m
//  TTPAutoCompleteView
//
//  Created by Bahman on 28/02/2014.
//
//

#import "AutoCompleteViewController.h"

@interface AutoCompleteViewController ()

@end

@implementation AutoCompleteViewController {
    NSMutableArray *filteredTableData;
}

@synthesize autoCompleteItems;
@synthesize textField;

+(id)viewBelowToUITextField:(UITextField *) textfield  withAutoCompleteItems:(NSMutableArray *)items;
{
    AutoCompleteViewController *autoCompleteViewController = [[AutoCompleteViewController alloc] init];
    autoCompleteViewController.autoCompleteItems = items;
    autoCompleteViewController.textField = textfield;
    autoCompleteViewController.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    autoCompleteViewController.tableView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [textfield.superview addSubview:autoCompleteViewController.view];
    return autoCompleteViewController;
}

-(id)init
{
    self = [super init];
    if (self) {
        autoCompleteItems = [[NSMutableArray alloc] init];
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    filteredTableData = [[NSMutableArray alloc] initWithArray:autoCompleteItems];
    CGRect frame = textField.frame;
    CGRect contentViewframe = CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, self.tableView.rowHeight*[autoCompleteItems count]);
    UIView *contentView = [[UIView alloc] initWithFrame:contentViewframe];
    contentView.autoresizesSubviews = YES;
    contentView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    contentView.backgroundColor = [UIColor clearColor];
    
    [self setView:contentView];
    
    self.tableView = [[UITableView alloc] initWithFrame:contentViewframe style:UITableViewStylePlain];
    [self.tableView setAutoresizesSubviews:YES];
    [self.tableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    
    
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    [[self view] addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.autoresizesSubviews = YES;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)recalculateHeight
{
    [self.tableView reloadData];
    CGRect frame = textField.frame;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, frame.size.width, self.tableView.rowHeight*[filteredTableData count]);
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.tableView.rowHeight*[filteredTableData count]);

    } completion:^(BOOL finished) {
    }];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textField removeTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (BOOL)textFieldDidChange:(UITextField *)textField
{
    if(self.textField.text.length == 0)
    {
        [filteredTableData removeAllObjects];
        [filteredTableData addObjectsFromArray:self.autoCompleteItems];
    }
    else {
        [filteredTableData removeAllObjects];
        for (NSString* string in self.autoCompleteItems) {
            NSRange nameRange = [string rangeOfString:self.textField.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
            if(nameRange.location != NSNotFound)
            {
                [filteredTableData addObject:string];
            }
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        [self.tableView reloadData];
        [self recalculateHeight];
    } completion:^(BOOL finished) {
    }];
    return YES;
}


-(void)updateViewConstraints
{
    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [filteredTableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [filteredTableData objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    // <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    // [self.navigationController pushViewController:detailViewController animated:YES];
    [self.textField setText:[self.autoCompleteItems objectAtIndex:indexPath.row]];
    if ([self.delegate respondsToSelector:@selector(selectedItemAtIndex:)]) {
        [self.delegate selectedItemAtIndex:indexPath.row];
    }
}

@end
