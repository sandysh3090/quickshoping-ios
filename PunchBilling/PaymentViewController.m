//
//  PaymentViewController.m
//  DemoQucikShop
//
//  Created by SANDEEP SHARMA on 27/02/16.
//  Copyright (c) 2016 Softex Lab. All rights reserved.
//

#import "PaymentViewController.h"
#import "Luhn.h"
#import "NSString+Additional.h"
#import "PunchhSoapApiClient.h"
#import "JSON.h"
#import "checkoutViewController.h"
#import "PaymentDetail.h"
#import "MBProgressHUD.h"

#define CC_DATA_STORE @"CC_data"

@interface PaymentViewController (){
    IBOutlet UIImageView *imgOr;IBOutlet UITextField *txtFName;
    IBOutlet UITextField *txtLName;
    IBOutlet UITextField *txtCvc;
    IBOutlet BKCardExpiryField *txtExp;
    IBOutlet BKCardNumberField *txtCardNumber;
    UITextField *txtReferance;
    NSMutableArray *arrCards;
    IBOutlet UIScrollView *ScrollCards;
    NSDictionary *billDIC;
}
@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    totalAmount.text=[NSString stringWithFormat:@"%@",self.usercart.itemOurPrice];
    txtCardNumber.showsCardLogo = YES;
    [self setLeftPadding:5.f withTextField:txtFName];
    [self setLeftPadding:5.f withTextField:txtLName];
    [self setLeftPadding:5.f withTextField:txtCvc];
    [self setLeftPadding:5.f withTextField:txtExp];
    [txtCardNumber setClearButtonMode:UITextFieldViewModeAlways];
    
    arrCards = [[[NSUserDefaults standardUserDefaults] valueForKey:CC_DATA_STORE] mutableCopy];
    if (arrCards.count==0) {
        orimg.alpha=0.0;
    }
    [self setCCSlider];
}
-(IBAction)backBtnTap:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)highlightLetter:(UITapGestureRecognizer*)sender {
    UIView *view = sender.view;
    NSLog(@"%ld", (long)view.tag);//By tag, you can find out where you had tapped.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    txtReferance=textField;
}

- (IBAction)TxtResign:(id)sender {
    [txtReferance resignFirstResponder];
}

- (IBAction)btnProceedTapped:(id)sender {
    if (btnCash.selected) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks"
                                                        message:@"Have you Complete your shoping."
                                                       delegate: self
                                              cancelButtonTitle:@"NO"
                                              otherButtonTitles:@"YES", nil];
        alert.tag=11;
        [alert show];
    } else {
        if ([self validate]) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"card_no=%@", txtCardNumber.text];
            NSArray *newArray = [arrCards filteredArrayUsingPredicate:predicate];
            if (!(newArray && newArray.count)) { // not exist
                // ask for save data ??
                [[[UIAlertView alloc] initWithTitle:@"Save!"
                                            message:@"Do you want to save this card for future quick checkout."  delegate:self
                                  cancelButtonTitle:@"NO"
                                  otherButtonTitles:@"YES", nil] show];
            } else {
                [self proceeedToSendData];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag==11) {
        switch (buttonIndex) {
            case 0:{
            }
                break;
            case 1:
            {
                PunchhSoapApiClient *service = [[PunchhSoapApiClient alloc] init];
                NSDictionary *bodyD=[[UserCart sharedCart] dictionaryRepresentation];
                [service getSoapApiResponse:[NSString stringWithFormat:@"%@bill/NO/%@",API_PATH,self.usercart.itemOurPrice] setHTTPMethod:@"POST" bodydata:[bodyD JSONRepresentation] success:^(AFHTTPRequestOperation *operation, NSDictionary* response) {
                    NSLog(@"ghgh %@",response);
                    billDIC=[[[NSDictionary alloc]initWithDictionary:response] mutableCopy];
                    [billDIC setValue:totalAmount.text forKey:@"amount_bill"];
                    [self performSegueWithIdentifier:@"chekoutViewcontroller" sender:nil];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Network not reachable,try again later" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                    [alert show];
                }];
            }
                break;
            default:
                break;
        }
    } else {
    if (buttonIndex != 0) {
        [self saveCardInfo];
    }
    [self proceeedToSendData];
    }
}

- (void)saveCardInfo {
    //-- save data here
    if (!arrCards) {
        arrCards = [[NSMutableArray alloc] init];
    }
    NSDictionary *dict = @{
                           @"fName":txtFName.text,
                           @"lName":txtLName.text,
                           @"exp":txtExp.text,
                           @"card_no": txtCardNumber.text,
                           @"cvv":txtCvc.text,
                           @"img":[self setStoreData:txtCardNumber.text]
                           };
    [arrCards addObject:dict];
    
    [[NSUserDefaults standardUserDefaults] setValue:arrCards forKey:CC_DATA_STORE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"%@",arrCards);
}

- (void)proceeedToSendData {
    //-- send data to server
    if (!self.usercart.paymentDetail) {
        self.usercart.paymentDetail = [PaymentDetail new];
    }
    self.usercart.paymentDetail.cardHolderName=[NSString stringWithFormat:@"%@ %@",txtFName.text,txtLName.text];
    self.usercart.paymentDetail.cardNo=txtCardNumber.text;
    [[MBProgressHUD showHUDAddedTo:self.view animated:YES] setLabelText:@"Processing"];
    PunchhSoapApiClient *service = [[PunchhSoapApiClient alloc] init];
    NSDictionary *bodyD=[self.usercart dictionaryRepresentation];
    [service getSoapApiResponse:[NSString stringWithFormat:@"%@bill/YES/%@",API_PATH,self.usercart.itemOurPrice] setHTTPMethod:@"POST" bodydata:[bodyD JSONRepresentation] success:^(AFHTTPRequestOperation *operation, NSDictionary* response) {
        NSLog(@"ghgh %@",response);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        billDIC= [[[NSDictionary alloc]initWithDictionary:response] mutableCopy];
        [billDIC setValue:totalAmount.text forKey:@"amount_bill"];
        [self performSegueWithIdentifier:@"chekoutViewcontroller" sender:nil];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Network not reachable,try again later" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }];
    [self setCCSlider];
}

- (BOOL)validate {
    if (!txtFName.text.present) {
        [self showAlert:@"Missing first name"];
    } else if (!txtLName.text.present) {
        [self showAlert:@"Missing last name"];
    } else if (!txtExp.text.present) {
        [self showAlert:@"Missing Expiry date."];
    } else if (!txtCvc.text.present) {
        [self showAlert:@"Missing CVV"];
    } else if (![txtCardNumber.text isValidCreditCardNumber]) {
        [self showAlert:@"Invalid card number"];
    } else {
        return YES;
    }
    return NO;
}

- (void)showAlert:(NSString*)msg {
    [[[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)setLeftPadding:(CGFloat)leftPadding withTextField:(UITextField*)textField {
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftPadding, textField.frame.size.height)];
    textField.leftView = paddingView;
    paddingView.backgroundColor = textField.backgroundColor;
    textField.leftViewMode = UITextFieldViewModeAlways;
    [textField setClearButtonMode:UITextFieldViewModeAlways];
}

- (IBAction)btnPaymentModeTapped:(UIButton*)sender {
    btnCard.selected = (sender == btnCard);
    btnCash.selected = !btnCard.selected;
}

- (NSString*)setStoreData:(NSString*)creditCard {
    switch ([creditCard creditCardType]) {
        case OLCreditCardTypeVisa:
            return @"visa_card";
            break;
        case OLCreditCardTypeMastercard:
            return @"master_card";
            break;
        default:
            return @"default_card";
            break;
    }
}

- (void)setCCSlider {
    int i,x;
    x=0;
    for (i=0; i<arrCards.count; i++) {
        NSDictionary *dict = arrCards[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0, ScrollCards.frame.size.width, ScrollCards.frame.size.height)];
        
        UIButton *btnSavedCard=[[UIButton alloc] initWithFrame:CGRectMake(40, 20, ScrollCards.frame.size.width-80, ScrollCards.frame.size.height-40)];
        [btnSavedCard addTarget:self action:@selector(btnSelectCardTapped:) forControlEvents:UIControlEventTouchUpInside];
        [btnSavedCard setImage:[UIImage imageNamed:dict[@"img"]] forState:UIControlStateNormal];
        btnSavedCard.tag=i;
        [view addSubview:btnSavedCard];
        
        UILabel *lblCardNumber = [[UILabel alloc] initWithFrame:CGRectMake(55, 90, ScrollCards.frame.size.width - 20, 80)];
        [lblCardNumber setNumberOfLines:0];
        [lblCardNumber setText:[NSString stringWithFormat:@"%@\nExpiry Date %@", [self changeEncryptText:dict[@"card_no"]], dict[@"exp"]]];
        [lblCardNumber setTextColor:[UIColor darkGrayColor]];
        [lblCardNumber setUserInteractionEnabled:NO];
        [view addSubview:lblCardNumber];
        
        [ScrollCards addSubview:view];
        x=x+ScrollCards.frame.size.width;
        ScrollCards.contentSize=CGSizeMake(x, ScrollCards.frame.size.height);
    }
}

- (NSString*)changeEncryptText:(NSString*)str {
    return [NSString stringWithFormat:@"XXXX XXXX %@", [str substringFromIndex:10]];
}

- (void)btnSelectCardTapped:(UIButton*)sender {
    NSDictionary *dict = arrCards[sender.tag];
    txtFName.text = dict[@"fName"];
    txtLName.text = dict[@"lName"];
    txtExp.text = dict[@"exp"];
    txtCardNumber.text= dict[@"card_no"];
    txtCvc.text = @"cvv";
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"chekoutViewcontroller"]) {
        checkoutViewController *viewController = segue.destinationViewController;
        viewController.billDic = billDIC;
    }
}

@end
