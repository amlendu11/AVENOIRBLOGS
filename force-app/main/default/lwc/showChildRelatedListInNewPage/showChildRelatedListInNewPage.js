import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ERROR from "@salesforce/label/c.ERROR";

export default class ShowChildRelatedListInNewPage extends LightningElement{
    @api relatedlists;
    @api objNaming;

    showTile = false;
    labels;
    isChildApiFound;
    isCampaign = false;
    childSize;

    connectedCallback() {
        if(this.relatedlists){
            //lead- campaign member logic
            if(this.objNaming == 'CampaignMember') {
                this.relatedlists = this.relatedlists.CampaignMember.map(item => item.Campaign);
                this.childSize = this.relatedlists.length;
                this.isCampaign = true;
                this.labels = (Object.entries(this.relatedlists[0]).map(([key,value])=>({ key, value })));
            }
            this.isChildApiFound = true;
        } else {
            this.dispatchEvent(
                new ShowToastEvent({
                    title : ERROR,
                    message : ERROR,
                    variant : 'Error'
                })
            );
        }
    }

    handleRefresh(event) {
        location.reload();
    }
}
