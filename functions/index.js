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
const {getFirestore} = require("firebase-admin/firestore");
const admin = require('firebase-admin');

admin.initializeApp();

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.testFunc = functions.region('europe-west3').https.onRequest((request, response) => {
    logger.info("Hello its me ");
    var abc = request.params[0];
    response.send("Hello from Dennis aaa " + abc);
})

exports.logNotifiCationOnDocCreate = functions.region('europe-west3').firestore
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

exports.pushNotifiCationOnDocCreate2 = functions.region('europe-west3').firestore
    .document('notification/{notificationId}')
    .onCreate(async (snapshot, context) => {
        const notificationData = snapshot.data();
        const ownerId = notificationData.ownerId;
        const abc = "1.1.2002";
        logger.info('für den Benutzer ' + notificationData.ownerId + ' wurde für den ' + abc + 'eine Benachrichtigung gescheduled');
        const ownerToken = (await getFirestore().collection('users').where('uid', '=', ownerId).get()).docs;
        logger.info(ownerToken.length);
        const ownerToken2 = ownerToken[0].get('token');
        logger.info(ownerToken2);
        const message = {
            
            notification: {
                title: "Neue Nachricht von BigD",
                body: "Neue Nachricht!",
            },
            token: ownerToken2
        }

        if (ownerToken2.length > 0) {
            // Send notifications to all tokens.
            const response = await admin.messaging().send(message);
            // await cleanupTokens(response, tokens);
            // functions.logger.log('Notifications have been sent and tokens cleaned up.');
          }
    });




exports.testDB = functions.region('europe-west3').firestore
    .document('notification/{notificationId}')
    .onCreate(async (snapshot, context) => {
        const testData = snapshot.data();
        const ownerId = testData.ownerId;
        logger.info(ownerId);
        const ownerToken = (await getFirestore().collection('users').where('uid', '=', ownerId).get()).docs;
        logger.info(ownerToken.length);
        const ownerToken2 = ownerToken[0].get('token');
        logger.info(ownerToken2);

    });

exports.testNot = functions.region('europe-west3').firestore
.document('tasks/{taskId}')
.onCreate(async (snapshot, context) => { 
    const testData = snapshot.data();
    const ownerId = testData.ownerId;
    const ownerToken = (await getFirestore().collection('users').where('uid', '=', ownerId).get()).docs;
    logger.info(ownerToken.length);
    const token = ownerToken[0].get('token');
    logger.info(token);
    admin
    .messaging()
    .send(
        {
        token: token,
        data: {
            foo: 'bar',
        },
        notification: {
            title: 'A great title',
            body: 'Great content',
        },
        },
    )
    .then((res) => {
        if (res.failureCount) {
        console.log('Failed', res.results[0].error);
        } else {
        console.log('Success');
        }
    })
    .catch((err) => {
        console.log('Error:', err);
    });

});