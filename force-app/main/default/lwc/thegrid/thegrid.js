/* eslint-disable vars-on-top */
import { LightningElement, track } from 'lwc';
//import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import MAPBOX from '@salesforce/resourceUrl/mapbox';

export default class TheGrid extends LightningElement {
    @track greeting = 'World';

    renderedCallback() {
        Promise.all([
            loadStyle(this, MAPBOX + '/mapbox-gl.css')
        ])
        .then(() => {
            alert('success');
            
        })
        .catch(error=>{
            alert('error');
        });
    }

    changeHandler(event) {
        this.greeting = event.target.value;
    }
}