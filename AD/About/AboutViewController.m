//
//  AboutViewController.m
//  AD
//
//  Created by DolBy on 13-5-15.
//  Copyright (c) 2013年 斌. All rights reserved.
//

//企业信息 联系我们 版本更新     关于本软件 帮助手册  版权说明  意见反馈
#import "AboutViewController.h"
#import "DetailViewController.h"
#import "HelpViewController.h"
#import "Harpy.h"
#import "ASDepthModalViewController.h"
#import "KGModal.h"


#import "About.h"
#import "Detail.h"
#define SCREENFRAME [[UIScreen mainScreen] applicationFrame]
@interface AboutViewController ()
@property(strong,nonatomic) NSArray *aboutArrayOne;
@property(strong,nonatomic) NSArray *aboutArrayTwo;
@property(strong,nonatomic)  UIButton *closeBtn;
@end

@implementation AboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"更多";
//        _aboutArrayOne = @[@"企业信息",@"联系我们",@"版本更新",nil];
//        _aboutArrayTwo = @[@"关于本软件",@"帮助手册",@"版权说明",@"意见反馈",nil];
        _aboutArrayOne = [NSArray arrayWithObjects:@"企业信息",@"联系我们",@"版本更新", nil];
        _aboutArrayTwo = [NSArray arrayWithObjects:@"关于本软件",@"帮助手册",@"版权说明",@"意见反馈", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _table = [[UITableView alloc] initWithFrame:SCREENFRAME style:UITableViewStyleGrouped];
    _table.backgroundColor = [UIColor whiteColor];
    _table.delegate =self;
    _table.dataSource = self;
    [self.view addSubview:self.table];
	About *_about = [[About alloc] initWithNibName:nil bundle:nil];
    Detail *_detail = [[Detail alloc] initWithNibName:nil  bundle:nil];
    about = _about;
    detail = _detail;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark UITableView Delegate Methods DataSourceDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.aboutArrayOne count];
    }
    else
    return [self.aboutArrayTwo count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentify = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
    }
    NSInteger section = [indexPath section];
    if (section == 0) {
        cell.textLabel.text = [self.aboutArrayOne objectAtIndex:indexPath.row];
        switch (indexPath.row) {
            case 0:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case 1:
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.detailTextLabel.text = @"10086";
                break;
            case 2:
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.detailTextLabel.text = @"V 1.0";
                break;
            default:
                break;
        }
    }
    if (section == 1) {
        cell.textLabel.text = [self.aboutArrayTwo objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       

    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UIView *copyRightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENFRAME.size.width-40, 300)];
    _closeBtn = [self buttonWithFrame:CGRectMake(30, 240, SCREENFRAME.size.width-100, 50) withNormalTitle:@"close" withOtherStateTitle:@"close" action:@selector(dismissView) andPosition:copyRightView];
    copyRightView.backgroundColor = [UIColor whiteColor];
    UITextView *txView = [[UITextView alloc] initWithFrame:CGRectMake(copyRightView.frame.origin.x+5, copyRightView.frame.origin.y+5, copyRightView.frame.size.width-10, copyRightView.frame.size.height-_closeBtn.frame.size.height-20)];
    txView.text = @"THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.";
    
    [copyRightView addSubview:txView];
    UIImage *img = [UIImage imageNamed:@"pattern1.jpg"];
    UIViewController *one = [[UIViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    [one.view setFrame:[[UIScreen mainScreen] applicationFrame]];
    [one.view setBackgroundColor:[UIColor cyanColor]];
    
    if ([indexPath section] == 0) {
        switch (indexPath.row) {
            case 0:
                //[self.navigationController pushViewController:about animated:YES];
                [self.navigationController presentViewController:nil animated:YES completion:NULL];
                break;
            case 1:
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
                break;
                case 2:
                [Harpy checkVersion];
                break;
            default:
                break;
        }
    }
    if ([indexPath section] == 1) {
        switch (indexPath.row) {
            case 0:
                [self showAction:nil];
                break;
            case 1:
                [self.navigationController pushViewController:nil animated:YES];
                break;
            case 2:
                
//            [ASDepthModalViewController presentView:copyRightView];
            [ASDepthModalViewController presentView:copyRightView withBackgroundColor:[UIColor colorWithPatternImage:img] popupAnimationStyle:ASDepthModalAnimationDefault];
                break;
            case 3:
                [[UIApplication sharedApplication]openURL:[NSURL   URLWithString:@"mailto://lihangqw@126.com"]]; 
                break;
                
            default:
                break;
        }
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return nil;
    }
    else return @"关于";
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section ==0) {
        return nil;
    }
    return @"版权所有";
    
}


- (UIButton *)buttonWithFrame:(CGRect)frame  withNormalTitle:(NSString *)title  withOtherStateTitle:(NSString *)otherTitle action:(SEL)action andPosition:(UIView *)v
{
    UIImage *buttonBackgroundImage = [[UIImage imageNamed:@"button_background.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    UIImage *disabledButtonBackgroundImage = [[UIImage imageNamed:@"button_background_disabled.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:otherTitle forState:UIControlStateDisabled];
    [button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:disabledButtonBackgroundImage forState:UIControlStateDisabled];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:button];
    
    return button;
}

-(void)dismissView
{
    [ASDepthModalViewController dismiss];

}
- (void)showAction:(id)sender{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 200)];
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 20;
    welcomeLabelRect.size.height = 20;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"关于AD";
    welcomeLabel.font = welcomeLabelFont;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:welcomeLabel];
    
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 5, 5);
    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect)+5;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
    infoLabel.text = @"AD 由10软工移动三班 iOS 组 李航 杜鑫峰 詹长如 刘玉英 应志超 朱红岩 制作";
    infoLabel.numberOfLines = 6;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.shadowColor = [UIColor blackColor];
    infoLabel.shadowOffset = CGSizeMake(0, 1);
    [contentView addSubview:infoLabel];
    
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
}
@end
