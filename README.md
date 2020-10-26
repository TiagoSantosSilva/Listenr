# Listenr

## Features
All required features were implemented. Some extras were implemented, those being:

* List of the Top 50 Tags
* Ability to search through the tag list
* Ability to change the tag of the albums being listed
* An error screen when a problem retrieving information from the API occurs

## Screenshots

![Album List](https://github.com/TiagoSantosSilva/Listenr/blob/main/Screenshots/Album%20List.PNG)
![Album Details](https://github.com/TiagoSantosSilva/Listenr/blob/main/Screenshots/Album%20List.PNG)
![Top Tags](https://github.com/TiagoSantosSilva/Listenr/blob/main/Screenshots/Top%20Tags.PNG)
![Error Screen](https://github.com/TiagoSantosSilva/Listenr/blob/main/Screenshots/Error%20Screen.PNG)


## Caching & Offline Mode
The app offers both Caching and Offline Mode.

The threshold set for caching was 1 hour (3600 seconds). This means that every time an API call is made, the app checks whether the same call was done in the last hour and, if a successful response was obtained, it is used instead.

Offline Mode works the same way but does not have a time limit. If the app is offline, it will use a successful response independent of when it was obtained.

## Unit Testing
Unit testing was done to the 3 parts of the modules. Tests were done to Classes, Extensions, Builders, View Models and Data Sources.

However, due to time constraints, not all the aimed to be done unit tests were finished.

The mocking of the networking layer wasn’t finished, making it not possible to successfully test methods that involved service calls. These tests were marked with the prefix `dont` (example: `dontTestSuccessfulServiceCall()`.

Other important parts of the app such as the DiskProvider class that offers Caching & Offline Mode should have been the focus of tests if there was more time left - this one has only a simple test checking if the time constraint is respected.
