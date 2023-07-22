@isTest
public class PasswordlessLoginController_Test {
    @testSetup
    static void makeData()
    {
    	cg__SDriveConfig__c sdrivesetting_SUrl_Community_Username = new cg__SDriveConfig__c();
		sdrivesetting_SUrl_Community_Username.Name = 'SUrl_Community_Username';
		sdrivesetting_SUrl_Community_Username.cg__Value__c = 'communitysurl@surl.com';
		insert sdrivesetting_SUrl_Community_Username;
        
        cg__SDriveConfig__c sdrivesetting_SUrl_Community_ClientId = new cg__SDriveConfig__c();
		sdrivesetting_SUrl_Community_ClientId.Name = 'SUrl_Community_ClientId';
		sdrivesetting_SUrl_Community_ClientId.cg__Value__c = 'ABCDEFGHIJ';
		insert sdrivesetting_SUrl_Community_ClientId;
        
        cg__SDriveConfig__c sdrivesetting_SUrl_Community_BaseUrl = new cg__SDriveConfig__c();
		sdrivesetting_SUrl_Community_BaseUrl.Name = 'SUrl_Community_BaseUrl';
		sdrivesetting_SUrl_Community_BaseUrl.cg__Value__c = 'https://test.cs99.force.com/surl';
		insert sdrivesetting_SUrl_Community_BaseUrl;
        
        cg__SDriveConfig__c sdrivesetting_SUrl_Community_Certificate = new cg__SDriveConfig__c();
		sdrivesetting_SUrl_Community_Certificate.Name = 'SUrl_Community_Certificate';
		sdrivesetting_SUrl_Community_Certificate.cg__Value__c = 'MySurl';
		insert sdrivesetting_SUrl_Community_Certificate;
    }

    @isTest static void passwordlessLoginTest()
    {
        if(Test.isRunningTest()){      
            PasswordlessLoginController controller = new PasswordlessLoginController();            
            String accessToken = controller.getAccessToken();
            System.assertEquals('', accessToken);
            PageReference pageReference = controller.JWTlogin();
            System.assertEquals(null, pageReference);
            
            PasswordlessLoginController controller2 = new PasswordlessLoginController();
            controller2.username = 'invalid@example.com';
            String accessToken2 = controller2.getAccessToken();
            System.assertEquals('', accessToken2);
            PageReference pageReference2 = controller2.JWTlogin();
            System.assertEquals(null, pageReference2);
            
            PasswordlessLoginController controller3 = new PasswordlessLoginController();
            controller3.clientId = 'invalidclientid';
            String accessToken3 = controller3.getAccessToken();
            System.assertEquals('', accessToken3);
            PageReference pageReference3 = controller3.JWTlogin();
            System.assertEquals(null, pageReference3);
            
            PasswordlessLoginController controller4 = new PasswordlessLoginController();
            controller4.communityBaseUrl = 'invalidcommunityBaseUrl';
            String accessToken4 = controller4.getAccessToken();
            System.assertEquals('', accessToken4);
            PageReference pageReference4 = controller4.JWTlogin();
            System.assertEquals(null, pageReference4);
            
            PasswordlessLoginController controller5 = new PasswordlessLoginController();
            controller5.certificate = 'surl';
            String accessToken5 = controller5.getAccessToken();
            System.assertEquals('', accessToken5);
            PageReference pageReference5 = controller5.JWTlogin();
            System.assertEquals(null, pageReference5);
        }
    }
}