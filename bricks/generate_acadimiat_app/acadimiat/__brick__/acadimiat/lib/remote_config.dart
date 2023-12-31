import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'Theme/theme_values.dart';
import 'core/globals.dart';


class FirebaseRemoteConfigClass{
  Future initializeConfig() async{
    ///This line creates a final variable remoteConfig that holds a singleton instance of FirebaseRemoteConfig class, which is used to fetch and activate remote configuration values from Firebase.
    final remoteConfig = FirebaseRemoteConfig.instance;
    ///This line fetches the latest remote configuration values from the Firebase Remote Config service by calling the fetch() method on the remoteConfig object, and it waits for the fetch operation to complete before proceeding to the next line of code using the await keyword.
    await remoteConfig.fetch();
    ///This line activates the latest fetched remote configuration values by calling the activate() method on the remoteConfig object. This makes the fetched configuration values available for use in the app, and ensures that they are used instead of the defaults. The method returns a Future<void> which completes with an error if the activation fails.
    await remoteConfig.activate();
    ///This line sets the configuration settings for the remoteConfig object by calling the setConfigSettings() method and passing in a RemoteConfigSettings object with the specified fetchTimeout and minimumFetchInterval durations.
    /// The fetchTimeout duration specifies the maximum amount of time to wait for a fetch operation to complete, while minimumFetchInterval specifies the minimum interval between fetch operations.
    /// These settings ensure that remote configuration values are fetched and activated at regular intervals, and that the fetch operation doesn't take too long to complete.
    /// This method returns a Future<void> which completes with an error if the configuration settings are invalid.
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 12),
    ));
    ///This line of code calls the getAll() method on the remoteConfig object, which retrieves all the key-value pairs of the fetched and activated remote configuration values.
    ///The method returns a Map<String, RemoteConfigValue> which contains all the configuration values as key-value pairs.
    /// Here, the returned Map is assigned to the variable temp.
    var temp =  remoteConfig.getAll();


    baseUrl = temp['baseUrl']!.asString();
    vimeoAccessKey=temp['vimeoAccessKey']!.asString();
    baseSignalRUrl=temp['baseSignalRUrl']!.asString();
    logo=temp['logo']!.asString();
    // enablePayment =temp['enablePayment']!.asBool();
    // publishableKey=temp['publishableKey']!.asString();
    // SECRET_KEY=temp['SECRET_KEY']!.asString();
    merchantIdentifier=temp['merchantIdentifier']!.asString();
    shareCourseText=temp['ShareCourseText']!.asString();

    primaryColorTypeString=temp['primaryColor']!.asString().replaceAll("0x","");
    primaryColor = Color(int.parse(temp['primaryColor']!.asString()));
    scaffoldBackgroundColorForLightTheme = Color(int.parse(temp['scaffoldBackgroundColorForLightTheme']!.asString()));
    scaffoldBackgroundColorForDarkTheme = Color(int.parse(temp['scaffoldBackgroundColorForDarkTheme']!.asString()));
    cardColorForLightTheme = Color(int.parse(temp['cardColorForLightTheme']!.asString()));
    cardColorForDarkMode = Color(int.parse(temp['cardColorForDarkMode']!.asString()));

   /**
    baseUrl="https://v1.elearning.technology";
    vimeoAccessKey="dc49a83832509209e473ffd03cacf85c";
    baseSignalRUrl="https://v1.elearning.technology/mastery";
    baseSignalRUrl="https://v1.emasteryacademy.com/mastery";


    await remoteConfig.setDefaults(const {
      "baseUrl": "https://v1.emasteryacademy.com",
      "vimeoAccessKey": "d83d133237fd6aa8c78760307719c021",
      "baseSignalRUrl": "https://v1.emasteryacademy.com/mastery"
    });


    await remoteConfig.setDefaults(const {
      "baseUrl": "https://v1.elearning.technology",
      "vimeoAccessKey": "dc49a83832509209e473ffd03cacf85c",
      "baseSignalRUrl": "https://v1.elearning.technology/mastery"
    });

    */

  }
}