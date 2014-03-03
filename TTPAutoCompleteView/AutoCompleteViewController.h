//
//  AutoCompleteViewController.h
//  TTPAutoCompleteView
//
//  Created by Bahman on 28/02/2014.
//
//

#import <UIKit/UIKit.h>

@protocol AutoCompleteViewDelegate <NSObject>

@required
-(void)selectedItemAtIndex:(NSInteger)index;

@end

@interface AutoCompleteViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *autoCompleteItems;
@property (strong, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UITextField *textField;
@property (weak, nonatomic) id<AutoCompleteViewDelegate>delegate;

+(id)viewBelowToUITextField:(UITextField *) textfield withAutoCompleteItems:(NSMutableArray *)items;
-(void)recalculateHeight;

@end
