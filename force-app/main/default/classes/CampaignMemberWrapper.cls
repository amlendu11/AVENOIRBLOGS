/***********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG50
------------------------------------------------------------------------
* Blog: Communicate to unrelated LWC components by NavigationMixing.
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Diksha Dewangan     24/08/2023   Initial Development
***********************************************************************/
public with sharing class CampaignMemberWrapper {
    public CampaignMember campaignMember;
    public CampaignMemberWrapper(CampaignMember CampaignMember) {
        this.campaignMember = campaignMember;
    }
}