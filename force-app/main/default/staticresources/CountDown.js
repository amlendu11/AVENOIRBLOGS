/**
 * Countdown Timer Web Component
 * 
 * Props
 * - date: The ending date of the countdown timer. Format: YYYY-MM-DDTHH:MM:SS
 * - heading: The heading of the countdown timer
 * - subheading: The subheading of the countdown timer
 * - theme: The theme of the countdown timer. Options: light, dark, (or optionally add your own)
 * - message: The message to display when the countdown timer is complete
 * - link: The link to display when the countdown timer is complete
 * - linktext: The text to display for the link when the countdown timer is complete
 * Events
 * - countdownComplete: Dispatched when the countdown timer is complete
 * - updateTimer: Dispatched every second when the countdown timer is running
 * - startTimer: Dispatched when the countdown timer starts
 * - stopTimer: Dispatched when the countdown timer stops
 */

class CountdownTimer extends HTMLElement {
    constructor() {
        super();
    }

    static get observedAttributes() {
        return ['date', 'heading', 'subheading', 'theme', 'message', 'link', 'linktext'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        if (oldValue !== newValue) {
            this[name] = newValue;
            this.render();
        }
    }

    connectedCallback() {
        if (!this.hasAttribute('message')) {
            this.setAttribute('message', 'Countdown Complete!');
        }

        if (!this.hasAttribute('linktext')) {
            this.setAttribute('linktext', 'Learn More');
        }

        if (!this.hasAttribute('theme')) {
            this.setAttribute('theme', 'light');
        }

        this.render();
        this.startTimer();
    }

    disconnectedCallback() {
        this.stopTimer();
    }

    get styles() {
        return`
            <style>
                .countdown-timer__title {
                    text-align: center;
                    font-family: inherit;
                }

                .countdown-timer__content {
                    display: flex;
                    flex-direction: row;
                    gap: 0.5rem;
                    justify-content: center;
                    align-items: center;
                    font-family: inherit;
                    min-height: 100px;
                }

                .countdown-timer__content .figure {
                    font-size: 28px;
                    font-weight: bold;
                    font-family: inherit;
                }

                .countdown-timer__content__counter.skeleton {
                    animation: pulse 3s ease-in-out infinite;
                }

                .countdown-timer__content__counter {
                    position: relative;
                    border: 1px solid #ccc;
                    border-radius: 5px;
                    background-color: #fff;
                    padding: 1rem;
                    min-width: 50px;
                    text-align: center;
                    padding-bottom: 1.5rem;
                    font-family: inherit;
                }

                .countdown-timer__content__counter .label {
                    position: absolute;
                    left: 0;
                    right: 0;
                    margin: auto;
                    bottom: 0.5rem;
                    font-size: 12px;
                    text-align: center;
                    font-family: inherit;
                }

                .countdown-timer__label {
                    text-align: center;
                    margin-top: 1rem;
                    font-family: inherit;
                }

                .countdown-timer__label a {
                    color: inherit;
                }

                .countdown-timer.theme--dark .countdown-timer__content__counter {
                    background-color: #000;
                    color: #fff;
                    border-color: #ccc;
                }

                .countdown-timer.theme--dark .countdown-timer__title {
                    color: white;
                }

                .countdown-timer.theme--dark .countdown-timer__label {
                    color: white;
                }

                @media only screen and (max-width: 386px) {
                    .countdown-timer__content__counter {
                        min-width: 40px;
                    }

                    .countdown-timer__content__counter .figure {
                        font-size: 16px;
                    }
                }

                @media only screen and (max-width: 346px) {
                    .countdown-timer__content__counter {
                        min-width: 23px;
                    }
                }

                @keyframes pulse {
                    0%, 100% { opacity: 0.8; }
                    25% { opacity: 0.3; }
                    50% { opacity: 0.8; }
                    75% { opacity: 0.3; }
                }
            </style>
        `;
    }

    get loadingState() {
        if (this.days === undefined) {
            return `
                <div class="countdown-timer__content__counter skeleton">
                    <span class="figure">--</span>
                    <span class="label">days</span>
                </div>
                <div class="countdown-timer__content__counter skeleton">
                    <span class="figure">--</span>
                    <span class="label">hours</span>
                </div>
                <div class="countdown-timer__content__counter skeleton">
                    <span class="figure">--</span>
                    <span class="label">minutes</span>
                </div>
                <div class="countdown-timer__content__counter skeleton">
                    <span class="figure">--</span>
                    <span class="label">seconds</span>
                </div>
            `;
        }

        return '';
    }

    get headingTemplate() {
        if (this.heading) {
            return`
                <div class="countdown-timer__title">
                    <h2>${this.heading}</h2>
                </div>
            `;
        }

        return '';
    }

    get subheadingTemplate() {
        if (this.subheading) {
            return`
            <div class="countdown-timer__label">
                <span>${this.subheading}</span>
            </div>
            `;
        }

        return '';
    }

    get completeTemplate() {
        return `
            <div class="countdown-timer theme--${this.theme}">
                <div class="countdown-timer__title">
                    <h2>${this.message}</h2>
                    ${this.link ? `
                        <div class="countdown-timer__label">
                            <a href="${this.link}">${this.linktext}</a>
                        </div>
                    ` : ''}
                </div>
            </div>
        `;
    }

    counter(timeProp) {
        return `
            <div class="countdown-timer__content__counter ${timeProp}">
                <span class="figure">${this[timeProp]}</span>
                <span class="label">${this[timeProp] !== 1 ? timeProp : timeProp.replace(/s$/, '')}</span>
            </div>
        `;
    }

    generateContent() {
        return `
            <div class="countdown-timer theme--${this.theme}">
                ${this.headingTemplate}
                <div class="countdown-timer__content">
                    ${this.loadingState}
                    ${this.days > 0 ? this.counter('days'): ''}
                    ${this.days > 0 || this.hours > 0 ? this.counter('hours') : ''}
                    ${this.days > 0 || this.hours > 0 || this.minutes > 0 ? this.counter('minutes') : ''}
                    ${this.seconds > -1 ? this.counter('seconds') : ''}
                </div>
                ${this.subheadingTemplate}
            </div>
        `;
    }

    updateTime() {
        if (!!this.date && new Date(this.date) == 'Invalid Date') {
            this.stopTimer();
            throw Error('Invalid date format. Please use the format: YYYY-MM-DDTHH:MM:SS');
        }

        this.endTime = new Date(this.date);
        this.currentTime = new Date();
        this.timeRemaining = this.endTime - this.currentTime;
        this.days = Math.floor(this.timeRemaining / (1000 * 60 * 60 * 24));
        this.hours = Math.floor((this.timeRemaining % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        this.minutes = Math.floor((this.timeRemaining % (1000 * 60 * 60)) / (1000 * 60));
        this.seconds = Math.floor((this.timeRemaining % (1000 * 60)) / 1000);
    }

    renderTime() {
        if (this.timeRemaining <= 0) {
            this.stopTimer();
            this.querySelector('.ct__container').innerHTML = this.completeTemplate;
            this.dispatchEvent(new CustomEvent('countdownComplete', { bubbles: true }));
            return;
        }

        this.querySelector('.ct__container').innerHTML = this.generateContent();
    }

    stopTimer() {
        clearInterval(this.timerInterval);
        this.dispatchEvent(new CustomEvent('stopTimer', {
            detail: {
                days: this.days,
                hours: this.hours,
                minutes: this.minutes,
                seconds: this.seconds
            },
            bubbles: true
        }));
    }

    startTimer() {
        this.updateTime();
        this.dispatchEvent(new CustomEvent('startTimer', { bubbles: true }));
        this.timerInterval = setInterval(() => {
            this.updateTime();
            this.renderTime();
            this.dispatchEvent(new CustomEvent('updateTimer', {
                detail: {
                    days: this.days,
                    hours: this.hours,
                    minutes: this.minutes,
                    seconds: this.seconds
                },
                bubbles: true
            }));
        }, 1000);
    }

    render() {
        this.innerHTML = `
            ${this.styles}
            <div class="ct__container">
                ${this.generateContent()}
            </div>
        `;
        this.renderTime();
    }
}

customElements.define('countdown-timer', CountdownTimer);