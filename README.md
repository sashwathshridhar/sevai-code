This folder contains the code for how the app Sevai processes and classifies information. It is written in JavaScript and is meant to be run using Node.js. By setting up an HTTPS endpoint, any POST request to this will return useful, processed information.

Due to the User Interface of this project largely being made in FlutterFlow, we are unable to share the every project file at the moment, but we have attached what we have access to.

`calculate.js` is simple functionality for calculating dates that we are trying to make more flexible.

`classifyParse.js` includes Natural Language Processing code that is built on `chrono-node`, `compromise`, `luxon`, and more for the date and time calculations done in calculate.js. This is a smaller version of the full processing code which uses intelligent classification, which we are trying to improve upon. As of now, this is functioning fully and we are working on a version that uses NER.

To run the code, download the files and run them binding to an open port. After this, the API should be accessible through POST requests (this can be by tested using `curl.exe` or similar).
