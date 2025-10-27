const express = require('express');

const { DateTime } = require('luxon');
const nlp = require('compromise');
const chnode = require('chrono-node');

const app = express();

app.use(express.json());

app.post('/text-processing', (req, res) =>{
    
const { sentence } = req.body;
let startTime = 'Not Available';
let endTime = 'Not Available';
let duration = 'Not Available';

const doc = nlp(sentence);
const times = chnode.parse(sentence);

const format = 'h:mm a'

if (times.length > 0) {
    const startParsed = times[0].start ? times[0].start.date() : null;
    const endParsed = times[0].end ? times[0].end.date() : null;

    if (startParsed) {
        startTime = startParsed ? DateTime.fromJSDate(startParsed).toFormat(format) : 'Not Available';
    }
    if (endParsed) {
        endTime = endParsed ? DateTime.fromJSDate(endParsed).toFormat(format) : 'Not Available';
    }
    let start = DateTime.fromJSDate(startParsed);
    let end = DateTime.fromJSDate(endParsed);

    if (end < start) {
        end = end.plus({days: 1});
    }

    let duration = end.diff(start, ['hours', 'minutes', 'seconds']);
    let { hours, minutes, seconds } = duration.toObject();

    durationStrFmt = `${Math.floor(Math.abs(hours))}h. ${Math.floor(Math.abs(minutes))}m. ${Math.floor(Math.abs(seconds))}s.`;

    console.log('Start Time: ', startTime);
    console.log('End Time: ', endTime);
    console.log('Start Date: ', startParsed);
    console.log('End Date: ', endParsed);
    console.log('Duration: ', durationStrFmt);
}
else if (times.length === 0) {
    const startParsed = times[0].start ? times[0].start.date() : null;

    let startTime = startParsed ? DateTime.fromJSDate(startParsed).toFormat('h:mm a') : 'Not Available';

    let duration = 'Not Available';
};
const locations = doc.places().out('array');
// const duration = doc.match('#Duration').out('array');
const activities = doc.verbs().out('array');

// Listing multiple activities from the array
if (activities.length > 0) {
    console.log('Activites: ', activities.join(', '));

}

res.json({    
    Activities: activities.join(', ') || 'None',
    Locations: locations.join(', ') || 'None',
    'Start Time': startTime,
    'End Time': endTime,
    Duration: durationStrFmt
});

});

let port = 3000;
app.listen(3000, () => {console.log(`Listening on port ${port}...`)});

