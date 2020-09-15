
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().functions);

var newData;

exports.myTrigger = functions.firestore
  .document("url/{id}")
  .onUpdate(async (snapshot, context) => {
    //

    const newValues = snapshot.after.data();
    const previousValues = snapshot.before.data();

    if (newValues !== previousValues) {
      const deviceIdTokens = await admin
        .firestore()
        .collection("DeviceIDToken")
        .get();

      var tokens = [];

      for (var token of deviceIdTokens.docs) {
        tokens.push(token.data().device_token);
      }
      var payload = {
        notification: {
          title: "A Position is Opened/Closed ",
          body: "Open to see Signal",
          image: "https://meet.google.com/linkredirect?authuser=0&dest=https%3A%2F%2Flh3.googleusercontent.com%2Fproxy%2FBoUIjttKZLWh5YleJCYREawSXBQTlRJOAPARnQLDuf1ZTEdxuYs3jocRqlvIMC2MeOne6TWL2vYsU8zyI49YkPoDSaF0QnrfNg",
          sound: "default",
        },
        data: {
          push_key: "Push Key Value",
          key1: "newData.data",
        },
        
      };

      try {
        const response = await admin.messaging().sendToDevice(tokens, payload);
        console.log("Notification sent successfully");
      } catch (err) {
        console.log(err);
      }
    }
  });
