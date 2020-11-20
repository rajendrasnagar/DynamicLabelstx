/**
* @author : Rajendra Singh Nagar
* @date : 2020-11-19 18:23:43
* @description : Class to get labels information dynamically
* @comments: Without sharing as labels should be accessible to all users.
*/
public without sharing class DynamicLabels{
    public String language { get; set; }
    public List<String> labels { get; set; }
     
    /**
    * @author : Rajendra Singh Nagar
    * @date : 2020-11-19 21:27:19
    * @description : Constructor
    */
    public DynamicLabels() {
         Map<String, String> reqParams = ApexPages.currentPage().getParameters();
         language = reqParams.get('language');
        // expecting labels to be separated by , 
        labels = reqParams.get('labels').split(',');
    }
    
    /**
    * @author : Rajendra Singh Nagar
    * @date : 2020-11-19 21:27:33
    * @description : This is an example Method to invoke LabelService & parse label values. It will support translations as well.
    * @param : (String) labels, (String) language
    * @return : (Map<String, String>)
    */
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getLabels(String labels,String language ){
        try{
            Map<String, String> mapLabelValue = new Map<String, String>();
            PageReference pr = Page.DynamicLabels;// the vf page
            pr.getParameters().put('language', language);
            pr.getParameters().put('labels', labels);
            Integer i = 0;
            list<String> listLabels = new list<String>();
            listLabels = labels.split(',');
            for(String rec: pr.getContent().toString().trim().split('\n')){
                // add to the map & increment i
                mapLabelValue.put(listLabels[i++], rec.trim());
            }
            return mapLabelValue;
        } catch(Exception e){
            throw new AuraHandledException('Expections in parsing labels.'+e.getMessage());
        }  
    }
}