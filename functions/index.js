/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const functions = require("firebase-functions");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.testFunc = functions.region('europe-west3').https.onRequest((request, response) => {
    logger.info("Hello its me");
    var abc = request.params[0];
    response.send("Hello from Dennis" + abc);
})

exports.notifiCationOnDocCreate = functions.region('europe-west3').firestore
    .document('tasks/{taskId}')
    .onCreate(async (snapshot, context) => {
        const taskId = context.params.taskId;
        const taskData = snapshot.data();
        const sender = taskData.ownerId;
        const name = taskData.description;

        logger.info('Ein neues Dokument wurde erstellt');
        logger.info('Das ToDo ' + name + ' Dokument wurde von ' + sender + ' erstellt.')
    }
);
