/***********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG50
------------------------------------------------------------------------
* Blog: Communicate to unrelated LWC components by NavigationMixing.
* Test class : ChildObjectsControllerTest
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Diksha Dewangan     24/08/2023   Initial Development
***********************************************************************/
public with sharing class ChildObjectsController {

    /**
    * This method aims to take make payload in json format respective to the api name provided in LWC
    * @param : childApiNames - list of Api name of the child to be queried
    * @param : parentObjectId - parentObjectId
    * @return : parentObjectName - parentObjectName
    */
    @AuraEnabled(cacheable=true)
    public static Map<String, List<sObject>> getChildRecordDetails(
        list<String> childApiNames,
        String parentObjectId,
        String parentObjectName
    ) {
        Map<String, List<sObject>> childApiAndLists = new Map<String, List<sObject>>();
        childApiAndLists.put(
            'CampaignMember',
            CampaignMemberProcessor.childRecordDetailsQueryHelper('CampaignMember', parentObjectId, parentObjectName)
        );
        return childApiAndLists;
    }
}