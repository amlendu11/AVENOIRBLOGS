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
public class CampaignMemberDomain {

    /**
    * This method aims to fetch the related campaignMember
    * @param leadId
    */
    public static List<CampaignMember> getCampaignMemberByLeadId(String leadId) {
        return [
            SELECT
                Campaign.Id,
                Campaign.Name,
                Campaign.IsActive,
                Campaign.Status,
                Campaign.Type,
                Campaign.CreatedDate
            FROM 
                CampaignMember
            WHERE 
                leadId =: leadId
            LIMIT 999
        ];
    }
}
