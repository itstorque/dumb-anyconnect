#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Library/KFKeychain.h"

@interface CustomCellWithLabelAndTextView : UITableViewCell {
    UILabel *label;
    UITextField *textField;
}

@property(retain, nonatomic) UITextField *textField; // @synthesize textField;
@property(retain, nonatomic) UILabel *label; // @synthesize label;

@end

@interface CredentialPromptsViewController : UIViewController
{
    UITableView *credentialPromptsTableView;
    UIActivityIndicatorView *activityIndicator;
    UILabel *activityIndicatorLabel;
    NSMutableDictionary *userPromptDict;
    NSMutableDictionary *m_inputControlMap;
    NSMutableDictionary *m_guiTypeMap;
    NSMutableArray *m_visiblePromptEntries;
    NSMutableArray *m_visibleTextFields;
    NSString *m_statusMessage;
    NSString *m_bannerMessage;
    _Bool m_bCertEnroll;
    _Bool m_bGetNewToken;
    _Bool m_bFirstLoad;
    UITextField *m_activeTextField;
    _Bool m_bKeyboardVisible;
    _Bool dismissModalViewFlag;
    UITextField *m_usernameTextField;
    UITextField *m_secondaryUsernameTextField;
    id credPromptsDelegate; // <CredentialPromptsDelegate>
}

@property(retain, nonatomic) UITextField *m_secondaryUsernameTextField; // @synthesize m_secondaryUsernameTextField;
@property(retain, nonatomic) UITextField *m_usernameTextField; // @synthesize m_usernameTextField;
@property(retain, nonatomic) UILabel *activityIndicatorLabel; // @synthesize activityIndicatorLabel;
@property(retain, nonatomic) UIActivityIndicatorView *activityIndicator; // @synthesize activityIndicator;
@property(retain, nonatomic) UITableView *credentialPromptsTableView; // @synthesize credentialPromptsTableView;
@property(nonatomic) _Bool dismissModalViewFlag; // @synthesize dismissModalViewFlag;
@property(nonatomic) __weak id credPromptsDelegate; // @synthesize credPromptsDelegate; // <CredentialPromptsDelegate>
@property(retain, nonatomic) NSMutableDictionary *userPromptDict; // @synthesize userPromptDict;
- (void)presentationControllerDidDismiss:(id)arg1;
- (void)LangChanged;
- (void)credentialPromptsGroupSave:(id)arg1;
- (void)textFieldDidEndEditing:(id)arg1;
- (void)textFieldDidBeginEditing:(id)arg1;
- (_Bool)textFieldShouldReturn:(id)arg1;
- (double)tableView:(id)arg1 estimatedHeightForRowAtIndexPath:(id)arg2;
- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2;
- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 willSelectRowAtIndexPath:(id)arg2;
- (id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2;
- (long long)tableView:(id)arg1 numberOfRowsInSection:(long long)arg2;
- (long long)numberOfSectionsInTableView:(id)arg1;
- (void)keyboardWillHide;
- (void)keyboardDidShow;
- (void)dealloc;
- (void)viewDidLayoutSubviews;
- (void)viewDidDisappear:(_Bool)arg1;
- (void)viewWillAppear:(_Bool)arg1;
- (void)didReceiveMemoryWarning;
- (void)willAnimateRotationToInterfaceOrientation:(long long)arg1 duration:(double)arg2;
- (void)viewDidAppear:(_Bool)arg1;
- (void)viewDidUnload;
- (void)viewDidLoad;
- (void)processRightBarButton;
- (void)localizeUI;
- (void)themeUI;
- (void)initTableHeaderAndFooter;
- (void)scrollToActiveTextField;
- (void)getNewToken:(id)arg1;
- (void)certEnroll:(id)arg1;
- (void)cancel;
- (void)connect;
- (void)updateGroup;
- (void)gatherUserPrompt:(id)arg1;
- (void)gatherUserPrompts;
- (void)clearUserPrompts;
- (void)hideSpinnerView;
- (void)showSpinnerViewWithLabel:(id)arg1;
- (_Bool)processUserPrompts;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

- (UITableViewCell *) buttonCell: (UITableView *)tableView title:(NSString *)title selector:(SEL) selector;

@end
