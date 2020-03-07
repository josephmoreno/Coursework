// "Functions Required For Assignment" Section	||
// Written by Joseph Daniel Moreno		||
//						||
// All other files provided by the course	||
// instructor.					||
//						||
// This project's objective is to have the	||
// student use a functional programming		||
// approach; implementation involves using	||
// Ramda (https://ramdajs.com).	The functions	||
// required return certain data from the	||
// flickrData passed to them.			||
//===============================================
const R = require('ramda');

/* ********************************************************************************************** */
/* ****************************          Predicate  Methods           *************************** */
/* ********************************************************************************************** */
// Check if value of x is 0. Return true if x is 0, false otherwise.
const isZero = x => x === 0;

// Check if value of the input is Alphanumeric. Return true if it is, false otherwise.
const isAlphaNumeric = R.compose(isZero, R.length(), R.match(/[^a-zA-Z0-9]/g));

// Compare to string (Commonly used for sorting strings). Return true string a is less than string
// b, false otherwise.
const compareStrings = R.comparator((a, b) => a < b);

// Takes a property (prop) of an object and converts it to a JS date object. Useful for the
// 'date_taken' property of Flickr data. Use: lensPropToJSDate('date_taken') => Date Object. Returns
// Date object
const lensPropToJSDate = prop => R.over(R.lensProp(prop))(item => new Date(item));

/* ********************************************************************************************** */
/* ****************************            Helper Methods             *************************** */
/* ********************************************************************************************** */
// Takes input of 1 or more string object separated by spaces (like the tags of the flickr data) in
// arrays, and turns them into an array of single word string objects.
const combineStringArray = R.compose(
  R.split(' '),
  R.join(' '),
);

/* ********************************************************************************************** */
/* **************************** Filtering Properties From Flickr JSON *************************** */
/* ********************************************************************************************** */
// Returns the array of objects in the item property
const flickrImageData = R.compose(
  R.prop('items'),
);

// Returns an array of combined tags of all images in the items property
const flickrTags = R.compose(
  combineStringArray,
  R.map(R.prop('tags')),
  flickrImageData,
);

// Returns an array titles for the images in the items property
const flickrTitles = R.compose(
  R.map(R.prop('title')),
  flickrImageData,
);

/* ********************************************************************************************** */
/* ****************************   Functions Required For Assignment   *************************** */
/* ********************************************************************************************** */

// Function used in alphaNumericTagsUniq()
const setTags = R.compose(
	R.map((t) => t.toLowerCase()),
	R.filter((t) => isAlphaNumeric(t)),
);

const uniqueTagsArray = a => {
	let tags = [];

	// If the tag in array "a" hasn't been pushed into array "tags" yet,
	// then push it in. Otherwise, check the next tag in "a".
	for(let i = 0; i < a.length; ++i) {
		let unique = true;

		for(let j = 0; j < tags.length; ++j) {
			if (tags[j] === a[i]) {
				unique = false;
				break;
			}
		}

		if (unique === true)
			tags.push(a[i]);
	}

	return tags;
};

// Function used in commonTagByRank()
const setTagRank = (allTags) => {
	// Get only one instance of each tag in an array.
	const uniqueTags = uniqueTagsArray(allTags);
	let tagRanks = [];

	// Push the unique tags into a new array and assign it a frequency.
	for(let i = 0; i < uniqueTags.length; ++i) {
		tagRanks.push({"tag": uniqueTags[i], "freq": 0});
	}

	// Iterate through all tags and increment the frequency
	// for each instance of a tag.
	allTags.map((t) => {
		tagRanks.map((r) => {
			if (t === r.tag)
				++r.freq;
		});
	});

	// Sort the array by frequency.
	tagRanks.sort(function(r1, r2) {return r2.freq - r1.freq});

	return tagRanks;
};

// Replace these functions with the solutions for this project
const imageCount = (flickrData) => flickrData.items.length;

const alphaNumericTagsUniq = (flickrData) => {
	const unfilteredTags = setTags(flickrTags(flickrData));
	let tags = uniqueTagsArray(unfilteredTags);
	tags.sort();

	return tags;
};

const nonAlphaNumericTags = (flickrData) => {
	const nonANTags = (flickrTags(flickrData)).filter((t) => !isAlphaNumeric(t));
	return nonANTags;
};

const avgTitleLength = (flickrData) => {
	const titles = flickrTitles(flickrData);
	const avgTLength = (titles.reduce(((total, t) => total += t.length), 0)) / titles.length;
	return avgTLength;
};

const commonTagByRank = rank => (flickrData) => {
	const tags = setTags(flickrTags(flickrData));
	const tagRanks = setTagRank(tags);

	return tagRanks[rank].tag;
};

const oldestPhotoTitle = (flickrData) => {
	let dates = [];

	flickrData.items.map((photo) => {
		dates.push({"title": photo.title, "date_taken": photo.date_taken});
	});

	dates.sort(function(date1, date2) {
		return new Date(date1.date_taken) - new Date(date2.date_taken);
	});
	
	return dates[0].title;
};

/* ********************************************************************************************** */
/* ********************************************************************************************** */
/* ****************************          All JSON Test Code           *************************** */
/* ****************************             DO NOT ALTER              *************************** */
/* ********************************************************************************************** */
/* ********************************************************************************************** */
const fs = require('fs');
const {
  makePromiseTest, runAllPromiseTest, alphaNumericTagsUniqTest1, alphaNumericTagsUniqTest2,
} = require('./testsetup');

const flickrDataDog = JSON.parse(fs.readFileSync('dogs.json', 'utf8'));
const flickrDataLandscapes = JSON.parse(fs.readFileSync('landscapes.json', 'utf8'));

runAllPromiseTest([
  makePromiseTest('Is flickrDataDog an object?', typeof flickrDataDog, 'object'),
  makePromiseTest('Images count should be 20', imageCount(flickrDataDog), 20),
  makePromiseTest(
    'Should get an array of all the unique alphanumeric tags after transforming to lower case, '
    + 'sorted lexicographically',
    alphaNumericTagsUniq(flickrDataDog), R.sort(compareStrings)(alphaNumericTagsUniqTest1),
  ),
  makePromiseTest(
    'Should Only Be 1 non alphanumeric tag as "świnoujście"',
    R.compose(R.head, nonAlphaNumericTags)(flickrDataDog), 'świnoujście',
  ),
  makePromiseTest(
    'Average Title Length Should be 26 (Rounded)',
    R.compose(Math.round, avgTitleLength)(flickrDataDog), 26,
  ),
  makePromiseTest(
    'Third most common tag should be "puppy" (0 index, where 0 is most common)',
    commonTagByRank(2)(flickrDataDog), 'puppy',
  ),
  makePromiseTest(
    'Oldest Photo Taken Title Should Be "20160626_P1060675"',
    oldestPhotoTitle(flickrDataDog), '20160626_P1060675',
  ),
]);

runAllPromiseTest([
  makePromiseTest('Is flickrDataLandscapes an object?', typeof flickrDataLandscapes, 'object'),
  makePromiseTest('Images count should be 20', imageCount(flickrDataLandscapes), 20),
  makePromiseTest(
    'Should get an array of all the unique alphanumeric tags after transforming to lower case, '
    + 'sorted lexicographically',
    alphaNumericTagsUniq(flickrDataLandscapes), R.sort(compareStrings)(alphaNumericTagsUniqTest2),
  ),
  makePromiseTest(
    'Should not be any non-alphanumeric tags (resulting in an [])',
    R.compose(nonAlphaNumericTags)(flickrDataLandscapes), [],
  ),
  makePromiseTest(
    'Average Title Length Should be 16 (Rounded)',
    R.compose(Math.round, avgTitleLength)(flickrDataLandscapes), 16,
  ),
  makePromiseTest(
    'Third most common tag should be "landscaping" (0 index, where 0 is most common)',
    commonTagByRank(2)(flickrDataLandscapes), 'landscaping',
  ),
  makePromiseTest(
    'Oldest Photo Taken Title Should Be "Boats of Golyazi"',
    oldestPhotoTitle(flickrDataLandscapes), 'Boats of Golyazi',
  ),
]);
