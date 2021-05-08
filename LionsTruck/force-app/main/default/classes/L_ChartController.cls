public class L_ChartController {

    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: This method is used to get the dataset needed (Assets records)
    to be rendered on the Chart LC,   
    **************************************************************************************************/    
    @AuraEnabled
    public static List<DataSet> getDataSet(id accountId){
        List<Asset> result = L_QueryHandler.getAssetsByAccountIds(new Set<id>{accountId});
        Map<String, Integer> nameCounterMap = new Map<String, Integer>();
        List<DataSet> dataSet = new List<DataSet>();
        
        if(result.isEmpty())
        {
            return dataSet;
        }
        
        for(Asset assetObj : result){
            if(!nameCounterMap.containsKey(assetObj.Name)){
                nameCounterMap.put(assetObj.Name, 1);
                continue;
            }
            Integer counterAux = nameCounterMap.get(assetObj.Name);
            nameCounterMap.put(assetObj.Name, ++counterAux);
        }
        
        prepareDataSet(dataSet, nameCounterMap);
        
        return dataSet; 
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: This method is used to populate the data set from the Assets Name of the Map parameter.
    **************************************************************************************************/
    public static void prepareDataSet(List<DataSet> dataSet, Map<String, Integer> nameCounterMap){
        for(String nameStr : nameCounterMap.keySet()){
            dataSet.add(new DataSet(nameStr, nameCounterMap.get(nameStr)));
        }
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: Class created to have easier handling way for front end side (LC).
    **************************************************************************************************/
    public class DataSet{
        public DataSet(String label ,Decimal count){
            this.label  = label ; 
            this.count = count ;
        }
        @AuraEnabled
        public String label {get;set;}
        @AuraEnabled
        public Decimal  count {get;set;}
    }
    
}