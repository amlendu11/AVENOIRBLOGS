import { LightningElement, wire, track, api } from 'lwc';
import getChildObjects from '@salesforce/apex/ChildObjectsController.getChildRecordDetails';
import { NavigationMixin } from 'lightning/navigation';
import VIEW_ALL from "@salesforce/label/c.VIEW_ALL";

export default class parentRelatedList extends NavigationMixin(LightningElement) {

    @api recordId;
    @api objectApiName;

    @track childApiAndLists;
    @track displayinSamePage=[];
    @track childRecords=[];

    error;
    isChildApiFound = false;
    relatedlistsize = 2;
    currentViewObj;
    showtile = true;
    label = {
        VIEW_ALL
    }

    connectedCallback() {
        this.relatedListDetails();
    }

    relatedListDetails() {
        getChildObjects({
            childApiNames : ['CampaignMember'],
            parentObjectId : this.recordId,
            parentObjectName : this.objectApiName
        }).then((result) => {
            this.childApiAndLists = result;
            this.childRecords = result;
            if (this.childApiAndLists){
                this.isChildApiFound = true;
            }
            //Array to display in frontend recor page
            this.displayinSamePage = this.childApiAndLists.CampaignMember.map(item => item.Campaign);
            let campaignsToFrontEnd =[];
            for(let index = 0; index < this.relatedlistsize; index++) {
                if(this.displayinSamePage[index]){
                    campaignsToFrontEnd.push(this.displayinSamePage[index])
                };
            }
            this.displayinSamePage = campaignsToFrontEnd;
            this.error = undefined;
        })
        .catch((error) => {
            this.error = error;
            this.childApiAndLists = undefined;
        });
    }

    navigateToCampaignComponent() {
        this.currentViewObj = 'CampaignMember';
        this.navigateToComponent();
    }

    navigateToComponent() {
        let cmpDef = {
            componentDef: "c:ShowChildRelatedListInNewPage",
            attributes : {
                relatedlists : this.childRecords,
                objNaming : this.currentViewObj
            }
        };
        let encodedDef = btoa(JSON.stringify(cmpDef));
        this[NavigationMixin.Navigate]({
            type: "standard__webPage",
            attributes: {
                url: "/one/one.app#" + encodedDef
            }
        });
    }
}
