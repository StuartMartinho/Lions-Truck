public class L_ServiceInteraction_TL {
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: To update Asset fields whenever a new Service Interaction is createdS
    **************************************************************************************************/
    public static void updateAssetDetails(List<L_ServiceInteraction__c> serviceInteractionList){
        
        Set<Id> assetIDs = getAssetsIds(serviceInteractionList);
        List<Asset> assetsToUpdate = new List<Asset>();
        List<Asset> assetsFromServices = L_QueryHandler.getAssetsWithVINByIds(assetIDs);
        sObject sObjAsset;
        
        for(Asset assetObj : assetsFromServices){
            L_Integration_TL.updateAssetInformation(assetObj.id, L_Constants.INT_ENDPOINTURL_VALUE,  L_Constants.HTTP_METHOD_GET, 120000, L_Constants.INT_CLIENTID_APINAME, L_Constants.INT_CLIENTSECRET_VALUE, assetObj.SerialNumber);
        }
        
        update assetsToUpdate;
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: get Asset Ids from ServiceInteraction List
    **************************************************************************************************/
    private static Set<Id> getAssetsIds(List<L_ServiceInteraction__c> serviceInteractionList){
        Set<Id> assetIds = new Set<Id>();
        
        for(L_ServiceInteraction__c serviceIObj : serviceInteractionList){
            assetIds.add(serviceIObj.L_Asset__c);
        }
        
        return assetIds;
    } 

}