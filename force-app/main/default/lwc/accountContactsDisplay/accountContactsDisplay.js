import { LightningElement, wire,track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccountList';
import Name from '@salesforce/label/c.Name';
import Id from '@salesforce/label/c.Id';
import NoContacts from '@salesforce/label/c.No_Contacts';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class AccountContactsDisplay extends NavigationMixin(LightningElement) {
    accounts;
    AccountMap = [];
    @track accountName;
    accountList = [];
    @track checkTrue = false;
    @track contactListShown;
    @track isModalOpen = false;
    Id = Id;
    Name = Name;
    NoContacts = NoContacts;

    @wire(getAccounts) getAccount({data,error}) {
        if(data){
            this.accounts=data;
            for(let i = 0; i < data.length ; i++) {
                let contacts = data[i]["account"]["Contacts"];
                let contactList = [];
                if(contacts){
                    for(let j = 0; j < contacts.length; j++){
                        let Name = contacts[j]["FirstName"] != null? contacts[j]["FirstName"] + contacts[j]["LastName"]:contacts[j]["LastName"];
                        contactList.push({"key":contacts[j]["Id"], "Value":Name});
                    }
                }
                this.AccountMap.push({"key":data[i]["account"]["Id"]+","+data[i]["account"]["Name"], "value":JSON.stringify(contactList)});
            }
        }
        else if(error) {
            this.ShowToastEventError(error);
        }
    };

     // Navigate to View Contact Page
     navigateToViewContactPage(event) {
        let key = event.target.value;
        console.log('key>>>'+key);
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                "recordId": key,
                "objectApiName": "Contact",
                "actionName": "view",
            },
        });
    }

    handleClick(event) {
       let value = event.target.id;
       let Id = value.substring(0,18);
       this.AccountMap.forEach(element => {
            let key = JSON.stringify(element["key"]);
            let matchID = key.split(",")[0];
            if(matchID.match(Id)){
                let name =  key.split(",")[1];
                let len = name.length;
                this.accountName = name.substring(0,len-1);
                let contacts = element["value"];
                console.log("contact"+contacts);
                if(contacts.length > 2){
                    for(let i = 0; i < contacts.length ; i++) {
                        this.contactListShown = JSON.parse(contacts);
                    }
                    this.checkTrue = true;
                }
                else{
                    this.checkTrue = false;
                }
            }
        });
    }

    ShowToastEventError(error) {
        const event = new ShowToastEvent({
                title: "Error",
                message: error,
                variant: "Error",
        });
        this.dispatchEvent(event);
    }

    openModal(event) {
        // to open modal set isModalOpen tarck value as true
        this.isModalOpen = true;
        this.handleClick(event);
    }

    closeModal() {
        // to close modal set isModalOpen tarck value as false
        this.isModalOpen = false;
    }

    submitDetails() {
        // to close modal set isModalOpen tarck value as false
        //Add your code to call apex method or do some processing
        this.isModalOpen = false;
    }
}