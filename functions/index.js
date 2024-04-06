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
        const abc = "1.1.2002";
        logger.info('für den Benutzer ' + notificationData.ownerId + ' wurde für den ' + abc + 'eine Benachrichtigung gescheduled');
        const payload = {
        notification: {
            title: 'A scheduled Task has been created',
            body: 'The Task ' + notificationData.taskId + 'has been scheduled for ' + notificationData.maturityDate
            // title: `${snapshot.data().name} posted ${text ? 'a message' : 'an image'}`,
            // body: text ? (text.length <= 100 ? text : text.substring(0, 97) + '...') : '',
            // icon: snapshot.data().profilePicUrl || '/images/profile_placeholder.png',
            // click_action: `https://${process.env.GCLOUD_PROJECT}.firebaseapp.com`,
        },
        data: {
            type: 'app'
        }
        };
            // Get the list of device tokens.
        // const allTokens = await admin.firestore().collection('fcmTokens').get();
        const tokens = ['do1DZRTXlmb1w_D3R6Enr7:APA91bHoLcijPp_ZB7ahrRcLaWvb2F5n4wISQuLU2hg8chk0kps0_GH5uPl3ijlUxXRyGmNmeIFRWIo8T_4wo6w-IoFkvHeP3ItCfwR4qq2UNKApieZEj5T2dufsCRO7FAgAeJ8fo8T_'];
        // allTokens.forEach((tokenDoc) => {
        // tokens.push(tokenDoc.id);
        // });

        if (tokens.length > 0) {
            // Send notifications to all tokens.
            const response = await admin.messaging().sendToDevice(tokens, payload);
            // await cleanupTokens(response, tokens);
            // functions.logger.log('Notifications have been sent and tokens cleaned up.');
          }
    });

