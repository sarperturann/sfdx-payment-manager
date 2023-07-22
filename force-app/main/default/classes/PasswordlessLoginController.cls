global with sharing class PasswordlessLoginController {
    cg__SDriveConfig__c sdrivesetting_SUrl_Community_Username = cg__SDriveConfig__c.getValues('SUrl_Community_Username');
    public String username = sdrivesetting_SUrl_Community_Username.cg__Value__c;
    cg__SDriveConfig__c sdrivesetting_SUrl_Community_ClientId = cg__SDriveConfig__c.getValues('SUrl_Community_ClientId');
    public String clientId = sdrivesetting_SUrl_Community_ClientId.cg__Value__c;
    cg__SDriveConfig__c sdrivesetting_SUrl_Community_BaseUrl = cg__SDriveConfig__c.getValues('SUrl_Community_BaseUrl');
    public String communityBaseUrl = sdrivesetting_SUrl_Community_BaseUrl.cg__Value__c;
    cg__SDriveConfig__c sdrivesetting_SUrl_Community_Certificate = cg__SDriveConfig__c.getValues('SUrl_Community_Certificate');
    public String certificate = sdrivesetting_SUrl_Community_Certificate.cg__Value__c;
    
    public PageReference JWTlogin() {        
        String url = ApexPages.currentPage().getHeaders().get('referer')==null?'':ApexPages.currentPage().getHeaders().get('referer');
        String surlId = url==''?'':url.substring(url.lastIndexOf('sid=') + 4);
        
        system.debug('surlId: ' + surlId);
        String token = getAccessToken();
                   
        system.debug('token: ' + token);
        
        PageReference PR = New PageReference(communityBaseUrl + '/secur/frontdoor.jsp?sid=' + token + '&retURL=' + communityBaseUrl + '/s/?sid=' + surlId);
    	if(Test.isRunningTest()){
            PR = NULL;
        }               
        return PR;
    }
    
	public String getAccessToken()
    {
        String tokenEndpoint = communityBaseUrl + '/services/oauth2/token';
        
        Auth.JWT jwt = new Auth.JWT();
     
        jwt.setIss(clientId);
        jwt.setSub(username);
        jwt.setAud(communityBaseUrl);
        
        Auth.JWS jws = new Auth.JWS(jwt, certificate);

        Auth.JWTBearerTokenExchange bearer = new Auth.JWTBearerTokenExchange(tokenEndpoint, jws);

        String accessToken='';
        if(!Test.isRunningTest()){
            accessToken = bearer.getAccessToken();
        }
        
        return accessToken;
    }
}