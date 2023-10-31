/***********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG50
------------------------------------------------------------------------
* Blog: Communicate to unrelated LWC components by NavigationMixing.
* Test class: CampaignMemberProcessorTest.cls
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Diksha Dewangan     24/08/2023   Initial Development
***********************************************************************/
public with sharing class CampaignMemberProcessor {
    /**
    * This method aims to process the related campaignMember
    * @param leadId
    */
    public static List<CampaignMember> getCampaignMembers(String leadId) {
        List<CampaignMember> processedData = new List<CampaignMember>();
        for(CampaignMember campaignMember : CampaignMemberDomain.getCampaignMemberByLeadId(leadId)) {
            CampaignMemberWrapper camp = new CampaignMemberWrapper(campaignMember);
            processedData.add(camp.CampaignMember);
        }
        return processedData;
    }

    /**
    * This method aims to get the Object fields dynamically from the filedset on the object
    * @param : childApiName - Api name of the child to be queried
    * @param : parentObjectId - parentObjectId
    * @param : parentObjectName - parentObjectName
    */
    public static List<sObject> childRecordDetailsQueryHelper(
        String childApiName,
        String parentObjectId,
        String parentObjectName
    ) {
        list<sobject> result = new list<sobject>();
        try {
            //Query the records to display in lead related list
            if(childApiName == 'CampaignMember' && parentObjectName == 'Lead') {
                result = getCampaignMembers(parentObjectId);
            } else {
                result = null;
                throw new AuraHandledException(System.Label.VIEW_ALL);
            }
        } catch(Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
        return result;
    }
}
