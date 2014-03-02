//
//  AutoCompleteViewController.h
//  TTPAutoCompleteView
//
//  Created by Bahman on 28/02/2014.
//
//

#import <UIKit/UIKit.h>

@interface AutoCompleteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *autoCompleteItems;
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UITextField *textField;

+(id)viewBelowToUITextField:(UITextField *) textfield withAutoCompleteItems:(NSMutableArray *)items;
-(void)recalculateHeight;

@end
