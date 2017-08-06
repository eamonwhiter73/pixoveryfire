const functions = require('firebase-functions');
const admin = require('firebase-admin');
 
admin.initializeApp(functions.config().firebase);

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.onChangeEvent = functions.storage.object().onChange(event => {
  const object = event.data; // The Storage object.

  const fileBucket = object.bucket; // The Storage bucket that contains the file.
	const filePath = object.name; // File path in the bucket.
	const contentType = object.contentType; // File content type.
	const resourceState = object.resourceState; // The resourceState is 'exists' or 'not_exists' (for file/folder deletions).
	const metageneration = object.metageneration; // Number of times metadata has been generated. New objects have a value of 1.

	console.log(filePath);
});
