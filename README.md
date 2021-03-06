**JournalBits**

[ ![Codeship Status for launsh/journalbits](https://www.codeship.io/projects/92039d00-e686-0131-cf84-6e586953192b/status)](https://www.codeship.io/projects/25852)


**Dependencies**

Rails: 4.1
Ruby: 2.1.2
Database: Postgres

*Configuration:*

* You need to setup your own Twitter Application on the Twitter Dev portal and save its key and secret in environment variables
* Currently that is all the setup required other than running rake db:create and then rake db:migrate


This is a work in progress. I am working towards implementing a digital journal that collets all of your data each day from the following services, using their APIs:

   * GitHub
   * Twitter
   * Facebook
   * Wunderlist
   * Pocket
   * Fitbit
   * Evernote
   * Instapaper
   * Instagram
   * Last.fm
   * Moves
   * Health Graph (Runkeeper's API - includes Sleep Cycle integration)
   * WhatPulse
   * RescueTime

Potentially others will be added but those are the inital services I'm aiming for.

Currently the data model I have in mind is that a User has many "days", and a day has many "$service$_entries". Each of the entires for each service will contain data from the relevant API, for example a username, date and text for a tweet from Twitter's API. This will be available to be viewed in the app and/or via a daily/weekly email.
