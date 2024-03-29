//
//  HisSearch.m
//  功过格
//
//  Created by davia on 14-2-18.
//  Copyright (c) 2014年 powerplayer. All rights reserved.
//

#import "HisSearch.h"
#import "RecordSQLService.h"
@interface HisSearch ()

@end

@implementation HisSearch
@synthesize param;
@synthesize param2;
@synthesize right;
@synthesize wrong;
@synthesize will;
@synthesize seddnamevalue;
@synthesize addtimevalue;
NSMutableArray* seedList;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    //绑定TableView
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
    RecordSQLService   *sqlSer = [[RecordSQLService alloc] init];
    sqlRecordList *sqlInsert = [[sqlRecordList alloc]init];
    sqlInsert.addtime=param;
    
    seedList= [sqlSer  getThisDay:sqlInsert];

    [sqlSer release];
    
    
    
    
    UIImage *bgImage = [UIImage imageNamed:@"bg.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    
    //设置手势操作
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.rightSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    self.rightSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.leftSwipeGestureRecognizer];
    [self.view addGestureRecognizer:self.rightSwipeGestureRecognizer];
    
    [super viewDidLoad];
    
    UIBarButtonItem *btnHome = [[UIBarButtonItem alloc]
                                initWithTitle:NSLocalizedString(@"home", nil)
                                style:UIBarButtonItemStyleBordered
                                target:self
                                action:@selector(onHome:)];
    
    self.navigationItem.rightBarButtonItem = btnHome;
    [btnHome release];
    self.navigationItem.title = param;
}


- (void)handleSwipes:(UISwipeGestureRecognizer *)sender
{
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [seedList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    //   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //绑定tableview
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell){
        cell=[[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:(CellIdentifier)]
              autorelease];
    }
    //
    if(indexPath.row<seedList.count){
        sqlRecordList *a=   [seedList objectAtIndex:indexPath.row];
        
        cell.textLabel.text=a.seedName;
    }
    
    //半透明背景
    UIColor *altCellColor = [UIColor colorWithWhite:1.0 alpha:0.1];
    
    cell.backgroundColor = altCellColor;
    altCellColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    cell.textLabel.backgroundColor = altCellColor;
    cell.detailTextLabel.backgroundColor = altCellColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.row<seedList.count){
        sqlRecordList *a=   [seedList objectAtIndex:indexPath.row];
        
        
        NSLog(@"jumpingtoEdddit");
        
        NSString *str1 = [NSString stringWithFormat:@"%d",a.sqlid];
        
        
        param2=str1;
        right=a.righttext;
        wrong=a.wrongtext;
        will=a.willtext;
        addtimevalue=a.addtime;
        seddnamevalue=a.seedName;
        [self performSegueWithIdentifier:@"HisListToDetail" sender:self];
    }
    [UIView commitAnimations];
}





-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //
    if(param2){
        id segue2 = segue.destinationViewController;
        [segue2 setValue:param forKey:@"param"];
          [segue2 setValue:right forKey:@"right"];
          [segue2 setValue:wrong forKey:@"wrong"];
          [segue2 setValue:will forKey:@"will"];
        [segue2 setValue:seddnamevalue forKey:@"seddnamevalue"];
        [segue2 setValue:addtimevalue forKey:@"addtimevalue"];
    }
    
    
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void)dealloc {
    [super dealloc];
}

-(void)onHome:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}
@end
