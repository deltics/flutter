import * as functions from "firebase-functions";
import * as firebase from "firebase-admin";

firebase.initializeApp();

export const onNewChatMessage = functions.firestore.document("chat/{message}")
    .onCreate((snapshot, context) => {
      return firebase.messaging().sendToTopic("chat", {
            notification: {
              title: "New Message",
              body: snapshot.data().text,
              clickAction: "FLUTTER_NOTIFICATION_CLICK",
            },
          }).catch((error) => console.log(`Error sending to topic: ${error}`));
    });
