import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ID_Number__c from "@salesforce/schema/Id_Number_Search__c.ID_Number__c";

export default class IdSearch extends LightningElement {
    @track Id_Number_Search__c;
    vfid = 'https://my-demo--c.eu11.visual.force.com/apex/MyVisualforcePage?Id=';

    }