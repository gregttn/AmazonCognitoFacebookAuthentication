import Foundation

let CognitoStoreReceivedIdentityIdNotification: String = "CognitoStoreReceivedIdentityIdNotification"

class CognitoStore {
    let infoKey = "userInfo"
    
    let credentialsProvider: AWSCognitoCredentialsProvider
    let client: AWSCognito
    
    init(provider: AWSCognitoLoginProviderKey, token: String) {
        let logins = [provider.rawValue : token]
        
        AWSLogger.defaultLogger().logLevel = AWSLogLevel.Verbose
        
        credentialsProvider = AWSCognitoCredentialsProvider.credentialsWithRegionType(AmazonCognitoCredentials.region,
            accountId: AmazonCognitoCredentials.accountId,
            identityPoolId: AmazonCognitoCredentials.poolId,
            unauthRoleArn: AmazonCognitoCredentials.unauthArn,
            authRoleArn: AmazonCognitoCredentials.authArn,
            logins: logins)
    
        let configuration: AWSServiceConfiguration = AWSServiceConfiguration(region: AmazonCognitoCredentials.region, credentialsProvider: credentialsProvider)
        client = AWSCognito(configuration: configuration)
        
        AWSServiceManager.defaultServiceManager().setDefaultServiceConfiguration(configuration);
    }
    
    class func connectWithFacebook() -> CognitoStore {
        return CognitoStore(provider: AWSCognitoLoginProviderKey.Facebook, token: FBSession.activeSession().accessTokenData.accessToken)
    }
    
    func requestIdentity() {
        credentialsProvider.getIdentityId().continueWithBlock() { (task) -> AnyObject! in
            if var error = task.error {
                println("Could not request identity: \(error.userInfo)")
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName(CognitoStoreReceivedIdentityIdNotification, object: self, userInfo: ["identityId":self.credentialsProvider.identityId])
            }
            
            return nil
        }
    }

    func saveItem(key: String, value: String) {
        var dataSet: AWSCognitoDataset = client.openOrCreateDataset(infoKey)
        dataSet.synchronize()
        dataSet.setString(value, forKey: key)
        
        dataSet.synchronize()
    }
    
    func loadInfo(callback: (tasks: Dictionary<NSObject, AnyObject>) -> Void) {
        var dataSet: AWSCognitoDataset = client.openOrCreateDataset(infoKey)
        dataSet.synchronize().continueWithBlock { (task) -> AnyObject! in
            if var error = task.error {
                println("Could not sync data \(error.userInfo)")
            } else {
                callback(tasks: dataSet.getAll())
            }
            
            return nil
        }
    }
}