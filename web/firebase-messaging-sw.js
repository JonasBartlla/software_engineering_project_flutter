importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
    apiKey: "AIzaSyC7Ne-dvGauVhw-6ZgDL0flQfpoAWeYaAY",
    authDomain: "software-engineering-pro-e850e.firebaseapp.com",
    projectId: "software-engineering-pro-e850e",
    storageBucket: "software-engineering-pro-e850e.appspot.com",
    messagingSenderId: "1027002047166",
    appId: "1:1027002047166:web:2dc6a79ea89c88525a9cef",
    measurementId: "G-Y4KF6G2PR8"
  };

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});