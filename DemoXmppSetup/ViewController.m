//
//  ViewController.m
//  DemoXmppSetup
//
//  Created by shiv vaishnav on 14/08/14.
//  Copyright (c) 2014 Ranosys Technologies Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *messageField;

@end

@implementation ViewController
@synthesize userDetail;

- (AppDelegate *)appDelegate
{
	return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getAllRegisteredUsers];
	// Do any additional setup after loading the view, typically from a nib.
}
- (XMPPStream *)xmppStream
{
    return [[self appDelegate] xmppStream];
}

- (void)getAllRegisteredUsers {
    
    NSError *error = [[NSError alloc] init];
    NSXMLElement *query = [[NSXMLElement alloc] initWithXMLString:@"<query xmlns='http://jabber.org/protocol/disco#items' node='all users'/>"
                                                            error:&error];
    XMPPIQ *iq = [XMPPIQ iqWithType:@"get"
                                 to:[XMPPJID jidWithString:@"hemas-mac-mini.local"]
                          elementID:[[self xmppStream] generateUUID] child:query];
    [[self xmppStream] sendElement:iq];
}


- (IBAction)sendImage:(id)sender
{

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];

    NSData *dataF = UIImagePNGRepresentation(originalImage);
    NSString *imgStr=[dataF base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:@"Hi Hema"];

    NSXMLElement *ImgAttachement = [NSXMLElement elementWithName:@"attachement"];
    [ImgAttachement setStringValue:imgStr];

    NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
    [message addAttributeWithName:@"type" stringValue:@"chat"];
    [message addAttributeWithName:@"to" stringValue:userDetail.jidStr];
    [message addChild:body];
    [message addChild:ImgAttachement];

    [self sendMessage:originalImage];
        // [[[self appDelegate] xmppStream] sendElement:message];

        // Send Image to friend
}
-(IBAction)sendMessage:(id)sender
{
    NSString *messageStr = self.messageField.text;
    NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
    [body setStringValue:messageStr];
    
    NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
    [message addAttributeWithName:@"type" stringValue:@"chat"];
    [message addAttributeWithName:@"to" stringValue:userDetail.jidStr];
    [message addChild:body];
    
    [[self xmppStream] sendElement:message];
    self.messageField.text=@"";
}
- (IBAction)sendReq:(id)sender
{
    
    XMPPJID *jid = [XMPPJID jidWithString:@"rohit@hemas-mac-mini.local"];
    [[self appDelegate].xmppRoster addUser:jid withNickname:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    return YES;
}


@end
