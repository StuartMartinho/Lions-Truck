public without sharing class L_Integration_TL {
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: This method is used to do an HTTP callout with the ClientId, ClientSecret and 
    CorrelationID header values.
    **************************************************************************************************/
    public static HttpResponse doHttpCallOut(String endPointUrl, String callOutType, Integer timeInMiliSec, String clientId, String clientSecret, String guid)
    {
        
        try{
            Http http = new Http();
            HttpRequest calloutReq = new HttpRequest();
            
            calloutReq.setMethod(callOutType);
            calloutReq.setEndpoint(endPointUrl);
            calloutReq.setTimeout(timeInMiliSec);
            
            calloutReq.setHeader(L_Constants.INT_CLIENTID_APINAME, clientId);
            calloutReq.setHeader(L_Constants.INT_CLIENTSECRET_APINAME, clientSecret);            
            calloutReq.setHeader(L_Constants.INT_CORRELATIONID_APINAME, guid);
            
            HttpResponse response = http.send(calloutReq);
            
            return response;
        }catch(Exception ex){
            throw ex;
        }
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: This method is used to populate, through a mapping, Asset fields after the callout is done.
    **************************************************************************************************/
    @future(callout=true)
    public static void updateAssetInformation(Id assetId, String endPointUrl, String callOutType, Integer timeInMiliSec, String clientId, String clientSecret, String guid){
        
        try{

            List<Asset> assetsList = L_QueryHandler.getAssetsWithVINByIds(new Set<Id>{assetId});
            Asset assetAux;

            //getting the CMDT records in order to know which fields are needed to be mapped.
            List<L_CalloutMappingCMDT__mdt> assetCalloutMappingList = L_QueryHandler.getCalloutMapping('Asset');
            
            if(assetsList.isEmpty()){
                return;
            }
            
            HttpResponse response = doHttpCallOut(endPointUrl, callOutType, timeInMiliSec, clientId, clientSecret, guid);
            
            Map<String, Object> jsonResponseData = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
            sObject sObjAsset = Schema.getGlobalDescribe().get('Asset').newSObject();
            
            if(assetsList[0].L_VIN__c == jsonResponseData.get('vin')){
                for(L_CalloutMappingCMDT__mdt fieldMapData : assetCalloutMappingList){
                    sObjAsset.put(fieldMapData.L_FieldAPIName__c,jsonResponseData.get(fieldMapData.L_JSONAttributeName__c));
                }    
            }

            Asset assetToUpdate = (Asset) sObjAsset;
            assetToUpdate.Id = assetsList[0].id;
            upsert assetToUpdate;

        }catch(Exception ex){
            throw ex;
        }
    }

}