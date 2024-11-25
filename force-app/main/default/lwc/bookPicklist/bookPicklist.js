import {LightningElement, track} from 'lwc';
import PICKLISTS from '@salesforce/label/c.PICKLISTS';
import GENRES from '@salesforce/label/c.GENRES';
import SELECT_GENRES from '@salesforce/label/c.SELECT_GENRES';
import AVAILABLE_GENRES from '@salesforce/label/c.AVAILABLE_GENRES';
import SELECT_ONE_OR_MORE_GENRES from '@salesforce/label/c.SELECT_ONE_OR_MORE_GENRES';
import SUBGENRES from '@salesforce/label/c.SUBGENRES';
import SELECT_SUB_GENRES from '@salesforce/label/c.SELECT_SUB_GENRES';
import AVAILABLE_SUB_GENRES from '@salesforce/label/c.AVAILABLE_SUB_GENRES';
import SELECT_ONE_OR_MORE_SUB_GENRES from '@salesforce/label/c.SELECT_ONE_OR_MORE_SUB_GENRES';
export default class BookPicklist extends LightningElement {
  label = {
    PICKLISTS,
    GENRES,
    SELECT_GENRES,
    AVAILABLE_GENRES,
    SELECT_ONE_OR_MORE_GENRES,
    SUBGENRES,
    SELECT_SUB_GENRES,
    AVAILABLE_SUB_GENRES,
    SELECT_ONE_OR_MORE_SUB_GENRES
  };
@track genreOptions = [
        { label: 'Fiction', value: 'Fiction' },
        { label: 'Non-Fiction', value: 'NonFiction' },
        { label: 'Science Fiction', value: 'ScienceFiction' },
        { label: 'Fantasy', value: 'Fantasy' }
    ];
    @track selectedGenres = [];
    @track subGenreOptions = [];
    @track selectedSubGenres = [];

    handleGenreChange(event) {
        this.selectedGenres = event.detail.value;
        this.updateSubGenreOptions();
    }

    handleSubGenreChange(event) {
        this.selectedSubGenres = event.detail.value;
    }

    updateSubGenreOptions() {
        this.subGenreOptions = [];
        this.selectedGenres.forEach(genre => {
            if (genre === 'Fiction') {
                this.subGenreOptions = this.subGenreOptions.concat([
                    { label: 'Mystery', value: 'Mystery' },
                    { label: 'Romance', value: 'Romance' },
                    { label: 'Thriller', value: 'Thriller' }
                ]);
            } 
            else if (genre === 'NonFiction') {
                this.subGenreOptions = this.subGenreOptions.concat([
                    { label: 'Biography', value: 'Biography' },
                    { label: 'History', value: 'History' },
                    { label: 'Self-Help', value: 'SelfHelp' }
                ]);
            }
        });
    }
}