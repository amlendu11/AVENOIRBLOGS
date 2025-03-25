import { LightningElement } from 'lwc';

export default class WhitespaceDemo extends LightningElement {
  handleClick() {
    const brokenSelector = this.template.querySelector('[class="highlight yellow"]');
    console.log('Exact match selector (broken):', brokenSelector);

    const workingSelector = this.template.querySelector('.highlight.yellow');
    console.log('Class-based selector (working):', workingSelector);

    if (workingSelector?.classList.contains('highlight')) {
      console.log('Class "highlight" is present ✅');
    }
  }
}
