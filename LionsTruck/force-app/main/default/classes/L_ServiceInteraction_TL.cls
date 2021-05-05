public class L_ServiceInteraction_TL {
    
    public static void updateAssetDetails(List<L_ServiceInteraction__c> serviceInteractionList){
        
        Set<Id> assetIDs = getAssetsIds(serviceInteractionList);
        List<Asset> assetsToUpdate = new List<Asset>();
        List<Asset> assetsFromServices = L_QueryHandler.getAssetsWithVINByIds(assetIDs);
        String guid;
        sObject sObjAsset;
        
        for(Asset assetObj : assetsFromServices){
            guid = L_GuidUtility.newGuid();
            L_Integration_TL.updateAssetInformation(assetObj.id, L_Constants.INT_ENDPOINTURL_VALUE,  L_Constants.HTTP_METHOD_GET, 120000, L_Constants.INT_CLIENTID_APINAME, L_Constants.INT_CLIENTSECRET_VALUE, guid);
        }
        
        update assetsToUpdate;
    }
    
    private static Set<Id> getAssetsIds(List<L_ServiceInteraction__c> serviceInteractionList){
        Set<Id> assetIds = new Set<Id>();
        
        for(L_ServiceInteraction__c serviceIObj : serviceInteractionList){
            assetIds.add(serviceIObj.L_Asset__c);
        }
        
        return assetIds;
    } 

}