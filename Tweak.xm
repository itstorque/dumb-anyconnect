#import "Tweak.h"

%hook CredentialPromptsViewController

NSInteger FIELD_COUNT;

NSMutableArray* FIELDS;
NSMutableArray* FIELD_HIDDEN;
NSMutableArray* FIELD_DATA;
bool FILL_PASSWORD = NO;

- (void)textFieldDidEndEditing:(UITextField *)arg1 {

		CustomCellWithLabelAndTextView* cell = ((CustomCellWithLabelAndTextView*) arg1.superview.superview);
		UITableView* table = ((UITableView*) cell.superview);

		[FIELD_DATA replaceObjectAtIndex: [table indexPathForCell: cell].row
			withObject: [NSString stringWithFormat: @"%@", cell.textField.text] ];

		%orig;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	FIELD_COUNT = %orig;

	FIELDS = [NSMutableArray arrayWithCapacity: FIELD_COUNT];
	FIELD_HIDDEN = [NSMutableArray arrayWithCapacity: FIELD_COUNT];
	id temp = [KFKeychain objectForKey:@"dumb-anyconnect-FIELD_DATA"];
	if (temp)
		FIELD_DATA = temp;
	else
		FIELD_DATA = [NSMutableArray arrayWithCapacity: FIELD_COUNT];

	for (int i = 0; i < FIELD_COUNT; i++) {
	    [FIELDS addObject: [NSNull null]];
	    [FIELD_HIDDEN addObject: @NO];
		if (!temp)
			[FIELD_DATA addObject: @""];
	}

	return FIELD_COUNT + 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	UITableViewCell* orig_cell = %orig;

	if (indexPath.row < FIELD_COUNT) {

		CustomCellWithLabelAndTextView* cell = ((CustomCellWithLabelAndTextView*) orig_cell);

		[FIELDS replaceObjectAtIndex:indexPath.row withObject:cell];

		[FIELD_HIDDEN replaceObjectAtIndex:indexPath.row
			withObject: [NSNumber numberWithBool: cell.textField.secureTextEntry]];

		if (FILL_PASSWORD)
			cell.textField.text = FIELD_DATA[indexPath.row];

		return cell;

	} else if (indexPath.row == FIELD_COUNT) {

		return [self buttonCell: tableView title: @"Show Hidden Fields" selector: @selector(toggleShowPassword:)];

	} else if (indexPath.row == FIELD_COUNT+1) {

		return [self buttonCell: tableView title: @"Fill Password" selector: @selector(fillPassword:)];

	} else if (indexPath.row == FIELD_COUNT+2) {

		return [self buttonCell: tableView title: @"Save New Credentials" selector: @selector(savePassword:)];

	}

	return orig_cell;

}

%new
- (UITableViewCell *) buttonCell: (UITableView *)tableView title:(NSString *)title selector:(SEL) selector {

	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: title];

	if (cell==nil) {

		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: title];

		UIButton* button = [[UIButton alloc] init];

		button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[button setTranslatesAutoresizingMaskIntoConstraints:NO];

		[button setTitle:title forState:UIControlStateNormal];

		[cell addSubview:button];

		NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1 constant:0];

		NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeTop multiplier:1 constant:0];

		NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1 constant:0];

		NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeBottom multiplier:1 constant:0];

		[cell addConstraints:@[left, top, right, bottom]];

		NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];

		[button addConstraints:@[height]];

	   	[button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];

	 }

	 return cell;

}

%new(v@:)
- (void) toggleShowPassword: (UIButton *) sender {

	bool hidden = NO;

	for (int i = 0; i < [FIELDS count]; i++) {

		if ([((NSNumber*) FIELD_HIDDEN[i]) isEqual: @YES]) {

			UITextField* input = ((CustomCellWithLabelAndTextView*) FIELDS[i]).textField;
			input.secureTextEntry = !input.secureTextEntry;
			hidden = input.secureTextEntry;

		}

	}

	[sender setTitle: hidden ? @"Show Hidden Fields" : @"Hide Hidden Fields"
	 	forState:UIControlStateNormal];

}

%new(v@:)
- (void) fillPassword: (UIButton *) sender {

	FILL_PASSWORD = YES;

	[((UITableView*) sender.superview.superview) reloadData];

}

%new(v@:)
- (void) savePassword: (UIButton *) sender {

	[[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

	[KFKeychain setObject:FIELD_DATA forKey:@"dumb-anyconnect-FIELD_DATA"];

	[sender setTitle: @"Credentials Saved" forState:UIControlStateNormal];

	[NSTimer scheduledTimerWithTimeInterval:1.0
         target:self
         selector:@selector(resetSaveButton:)
         userInfo:sender
         repeats:NO];

}

%new(v@:)
- (void) resetSaveButton:(NSTimer*)timer {

	UIButton* save_button = (UIButton*)[timer userInfo];

	[save_button setTitle: @"Save New Credentials" forState:UIControlStateNormal];

}

%end
