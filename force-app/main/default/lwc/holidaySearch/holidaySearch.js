import { LightningElement } from 'lwc';
import getSearch from "@salesforce/apex/HolidayServiceController.getidNumberSearch";
import updateIdSearches from "@salesforce/apex/HolidayServiceController.updateIdNumberSearches";
import callout from "@salesforce/apex/CalendarificWrapperRetriever.getCalendarificData";
import IMAGE from "@salesforce/resourceUrl/SouthAfricanTable";

export default class HolidaySearch extends LightningElement {
    searchTerm = '';
    idSearchNum;
    updatedIdSearches;
    error;
    data;
    myPictureUrl = IMAGE;
    IsValid;
    dateOfBithDate;
    dateOfBirthMonth;
    gender;
    citizen;
    isValidNumber = false;

    handleOnchange(event) {
        this.searchTerm = event.target.value;
        this.dateOfBirthMonth = Number(this.searchTerm.charAt(2)+this.searchTerm.charAt(3));
        this.dateOfBithDate = Number(this.searchTerm.charAt(4)+this.searchTerm.charAt(5));
        this.gender = Number(this.searchTerm.charAt(6)+this.searchTerm.charAt(7)+this.searchTerm.charAt(8)+this.searchTerm.charAt(9));
        this.citizen = Number(this.searchTerm.charAt(10));
        if(this.gender < 9999 && this.dateOfBithDate < 31 && this.dateOfBirthMonth <= 31 && (this.citizen===0 || this.citizen===1)){
           this.isValidNumber = true;
        }
    }
    
    handleButtonClick() {
        if(!this.isValidNumber)
          alert('Id number is Invalid, please type in correct id number');
        
        else{
            if(this.searchTerm != null & this.isValidNumber) {
                getSearch({searchIDNum: this.searchTerm}).then(result => {
                    this.idSearchNum = result;
                })
                .catch(error => {
                    this.error = error;
                });
                updateIdSearches({IdsToUpdate: this.idSearchNum}).then(result =>{
                    this.updatedIdSearches = result;
                })
                .catch(error => {
                    this.error = error;
                });
                callout({Idyear: this.searchTerm}).then(result =>{
                    this.data = JSON.parse(result);
                })
                .catch(error =>{
                    this.error = error;
                });
            }
        }
    }

}