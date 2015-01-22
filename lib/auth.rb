class Auth
    #Constants Variables
    ACCESS_TOKEN_URL    = 'http://developer.globelabs.com.ph/oauth/access_token'
    OAUTH_URL           = 'http://developer.globelabs.com.ph/dialog/oauth';
	
    #Class Variables
    @@appId             = String.new
    @@appSecret         = String.new
	
    # Initialize App ID and App Secret
    def initialize(appId, appSecret)
        @@appId      = appId
        @@appSecret  = appSecret
    end
end
