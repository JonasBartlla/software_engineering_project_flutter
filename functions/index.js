const functions = require("firebase-functions");
const logger = require("firebase-functions/logger");
const {getFirestore} = require("firebase-admin/firestore");
const admin = require('firebase-admin');
const {onSchedule} = require("firebase-functions/v2/scheduler");

admin.initializeApp();


// exports.logNotifiCationOnDocCreate = functions.region('europe-west3').firestore
//     .document('tasks/{taskId}')
//     .onCreate(async (snapshot, context) => {
//         const taskId = context.params.taskId;
//         const taskData = snapshot.data();
//         const sender = taskData.ownerId;
//         const name = taskData.description;

//         logger.info('Ein neues Dokument wurde erstellt');
//         logger.info('Das ToDo ' + name + ' Dokument wurde von ' + sender + ' erstellt.')
//     }
// );

// exports.pushNotifiCationOnDocCreate2 = functions.region('europe-west3').firestore
//     .document('notification/{notificationId}')
//     .onCreate(async (snapshot, context) => {
//         const notificationData = snapshot.data();
//         const ownerId = notificationData.ownerId;
//         const abc = "1.1.2002";
//         logger.info('für den Benutzer ' + notificationData.ownerId + ' wurde für den ' + abc + 'eine Benachrichtigung gescheduled');
//         const ownerToken = (await getFirestore().collection('users').where('uid', '=', ownerId).get()).docs;
//         logger.info(ownerToken.length);
//         const ownerToken2 = ownerToken[0].get('token');
//         logger.info(ownerToken2);
//         const message = {
            
//             notification: {
//                 title: "Neue Nachricht von BigD",
//                 body: "Neue Nachricht!",
//             },
//             token: ownerToken2
//         }

//         if (ownerToken2.length > 0) {
//             // Send notifications to all tokens.
//             const response = await admin.messaging().send(message);
//             // await cleanupTokens(response, tokens);
//             // functions.logger.log('Notifications have been sent and tokens cleaned up.');
//           }
//     });




// exports.testDB = functions.region('europe-west3').firestore
//     .document('notification/{notificationId}')
//     .onCreate(async (snapshot, context) => {
//         const querySnapshot = await getFirestore().collection('notification').where('taskId', '=','cGlOXhifpn5DdMIF4WcM').get();
//         const taskId = querySnapshot.docs[0].id;
//         logger.info(taskId)
//         getFirestore().collection('notification').doc(taskId).update({'messageSent': true});


//     });

exports.tt = onSchedule("* * * * *", async (event) => {
    var currentDate = new Date();
    logger.info(currentDate.getTime());
    const querySnapshot = (await getFirestore().collection('notification').where('maturityDate', '<',currentDate.getTime() + (16 * 60 * 1000)).where('messageSent','=',false).get()).docs;
    logger.info(querySnapshot.length);
    if(querySnapshot.length >0){
        querySnapshot.forEach(async (doc) =>{
            notificationData = doc.data()
            logger.info(doc.id);

            const taskOwner = notificationData.ownerId; //get uid of owner
            logger.info('Owned by ' + taskOwner);
            const ownerToken = (await getFirestore().collection('users').where('uid', '=', taskOwner).get()).docs[0].data().token;
            logger.info('owner token' + ownerToken);
            if (ownerToken != ''){
                const affectedTaskId = notificationData.taskId; //get uid of task
                logger.info('Task referenced by ' + taskOwner);
                const taskData = (await getFirestore().collection('tasks').doc(affectedTaskId).get()).data(); //get the data of affected task
                admin
                .messaging()
                .send(
                    {
                    token: ownerToken,
                    data: {
                        foo: 'bar',
                        description: taskData.description,
                        list: taskData.list,
                        note: taskData.note,
                        priority: taskData.priority.toString()
                    },
                    notification: {
                        title: 'Ein ToDo wird fällig',
                        body: 'Ihr ToDo ' + taskData.description + ' wird fällig',
                    },
                    },
                );
                getFirestore().collection('notification').doc(doc.id).update({'messageSent': true});
                logger.info('NotificationSend set to true');
                
            }else{
                logger.info("The user disabled notifications no message will be sent");
            }



        });
    }else{
        logger.info('No notification needs to be sent');
    }

   
});

exports.testNot = functions.region('europe-west3').firestore
.document('notification/{notificationId}')
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

// exports.dateTimeCheck = functions.region('europe-west3').firestore
// .document('notification/{notificationId}')
// .onCreate(async (snapshot, context) => { 
//     const notificationData = snapshot.data();
//     var currentDate = new Date();
//     var maturityDate = new Date(notificationData.maturityDate - (15 * 60 * 1000));
//     logger.info(currentDate);
//     logger.info(maturityDate);
//     if (maturityDate < currentDate ){
//         logger.info('A Notification should be scheduled');
//     } else {
//         logger.info('Enough Time existing');
//     }
// });

// exports.sendNotificationForDueTasks = functions.region('europe-west3').firestore
// .document('notification/{notificationId}')
// .onCreate(async (snapshot, context) => { 
//     var currentDate = new Date();
//     logger.info(currentDate.getTime());
//     const querySnapshot = (await getFirestore().collection('notification').where('maturityDate', '<',currentDate.getTime() + (16 * 60 * 1000)).where('messageSent','=',false).get()).docs;
//     logger.info(querySnapshot.length);
//     if(querySnapshot.length >0){
//         querySnapshot.forEach(async (doc) =>{
//             notificationData = doc.data()
//             logger.info(doc.id);

//             const taskOwner = notificationData.ownerId; //get uid of owner
//             logger.info('Owned by ' + taskOwner);
//             const ownerToken = (await getFirestore().collection('users').where('uid', '=', taskOwner).get()).docs[0].data().token;
//             logger.info('owner token' + ownerToken);
//             if (ownerToken != ''){
//                 const affectedTaskId = notificationData.taskId; //get uid of task
//                 logger.info('Task referenced by ' + taskOwner);
//                 const taskData = (await getFirestore().collection('tasks').doc(affectedTaskId).get()).data(); //get the data of affected task
//                 admin
//                 .messaging()
//                 .send(
//                     {
//                     token: ownerToken,
//                     data: {
//                         foo: 'bar',
//                         description: taskData.description,
//                         list: taskData.list,
//                         note: taskData.note,
//                         priority: taskData.priority.toString()
//                     },
//                     notification: {
//                         title: 'Ein ToDo wird fällig',
//                         body: 'Ihr ToDo ' + taskData.description + ' wird fällig',
//                     },
//                     },
//                 );
//                 getFirestore().collection('notification').doc(doc.id).update({'messageSent': true});
//                 logger.info('NotificationSend set to true');
                
//             }else{
//                 logger.info("The user disabled notifications no message will be sent");
//             }



//         });
//     }else{
//         logger.info('No notification needs to be sent');
//     }


// });