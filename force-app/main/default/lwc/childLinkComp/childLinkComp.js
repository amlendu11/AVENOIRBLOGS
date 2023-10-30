import { LightningElement, api} from 'lwc';

export default class ChildLinkComp extends LightningElement {
    @api currentchildobject;
    @api showtile;

    get url() {
        return (
            window.location.origin + "/"+ this.currentchildobject.Id
        );
    }

    get objectProperties() {
        return (Object.entries(this.currentchildobject).map(([key, value])=>({key, value})));
    }
}