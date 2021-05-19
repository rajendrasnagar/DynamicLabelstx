import { LightningElement, wire } from 'lwc';
import getLabels from '@salesforce/apex/DynamicLabels.getLabels'

/**
 * TODO: Expose as independent component with icon.
 * TODO: Work on CI/CD on github
 */

export default class DynamicLabels extends LightningElement {
    labels;
    @wire(getLabels,{labels:'$labels'})
    getLabels(value){
        const {error, data} = value;
        if(data){
            console.log('***Wire:getLabels:success'+JSON.stringify(data, undefined, 4));
            const container = this.template.querySelector('.container');
            // container.innerHTML = JSON.stringify(data, undefined, 4);
            container.innerHTML = this.syntaxHighlight(JSON.stringify(data, undefined, 4));
            
        }else if(error){
            console.log('***Wire:getLabels:error');

        }
    }

    handleClick(event){
        console.log('***'+this.template.querySelector('[data-id="inputlabel"]').value);
        this.labels = this.template.querySelector('[data-id="inputlabel"').value;
    }

    syntaxHighlight(json) {
        // https://stackoverflow.com/questions/4810841/pretty-print-json-using-javascript
        if (typeof json != 'string') {
             json = JSON.stringify(json, undefined, 2);
        }
        json = json.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
        return json.replace(/("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g, function (match) {
            var cls = 'number';
            if (/^"/.test(match)) {
                if (/:$/.test(match)) {
                    cls = 'key';
                } else {
                    cls = 'string';
                }
            } else if (/true|false/.test(match)) {
                cls = 'boolean';
            } else if (/null/.test(match)) {
                cls = 'null';
            }
            return '<span class="' + cls + '">' + match + '</span>';
        });
    }
}