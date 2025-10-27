This folder contains the code for how the app Sevai processes and classifies information. It is written in JavaScript and is meant to be run using Node.js. By setting up an HTTPS endpoint, any POST request to this will return useful, processed information.

calculate.js is simple functionality for calculating dates that we are trying to make more flexible.

classifyParse.js includes full Natural Language Processing code that is built on chrono-node, compromise, and luxon for the date and time calculations done in calculate.js. This is a smaller version of the full processing code which uses Naive Bayes classification, which we are trying to improve upon.
