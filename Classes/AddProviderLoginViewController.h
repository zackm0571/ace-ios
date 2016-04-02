//
//  AddProviderLoginViewController.h
//  linphone
//
//  Created by Zack Matthews on 4/2/16.
//
//

#import <UIKit/UIKit.h>
#include "UICustomPicker.h"
#import <XMLRPCConnectionDelegate.h>
#import "UICompositeViewController.h"
#import "UILinphoneTextField.h"
#import "LinphoneUI/UILinphoneButton.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "AcceptanceVC.h"
#import "DefaultSettingsManager.h"
#import "AsyncProviderLookupOperation.h"
@interface AddProviderLoginViewController : UIViewController<UITextFieldDelegate,
XMLRPCConnectionDelegate,
UIGestureRecognizerDelegate,
UIAlertViewDelegate,
UITextFieldDelegate,
UICustomPickerDelegate,
AcceptanceVCDelegate,
DefaultSettingsManagerDelegate,
AsyncProviderLookupDelegate
>
{
@private
    UITextField *activeTextField;
    UIView *currentView;
    UIView *nextView;
    NSMutableArray *historyViews;
    UICustomPicker *providerPickerView;
}

@property (nonatomic, strong) IBOutlet UITapGestureRecognizer *viewTapGestureRecognizer;

@property (weak, nonatomic) IBOutlet UIView *advancedViewPanel;


@end
