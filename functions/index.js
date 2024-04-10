const functions = require("firebase-functions");
const logger = require("firebase-functions/logger");
const {getFirestore} = require("firebase-admin/firestore");
const admin = require('firebase-admin');
const {onSchedule} = require("firebase-functions/v2/scheduler");

admin.initializeApp();


exports.sendNotificationForDueTasks = onSchedule("* * * * *", async (event) => {
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
                var difference = Math.abs(Math.round((currentDate.getTime()-taskData.maturityDate)/60000));
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
                        title: 'Los CheckIT!',
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