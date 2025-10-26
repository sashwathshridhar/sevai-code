const express = require('express');
const { DateTime } = require('luxon');

const app = express();

app.use(express.json());

app.post('/calculate-date', (request, response) => {

    console.log('Received POST Request: ', request.body);

    const { startTime, endTime } = request.body;

    const format = 'h:mm a';
    let start = DateTime.fromFormat(startTime, format);
    let end = DateTime.fromFormat(endTime, format);

// This is to accommodate for extended period that wrap-around
    if (end < start) {
        end = end.plus({days: 1});
    }

    const startDate = DateTime.fromObject(start.hour, start.minute, start.second).toFormat(format);

// Error handling
    if (!start.isValid || !end.isValid) {
        response.status(400).json('Please enter valid times for start and end.');
    }

// Report times with hours, minutes, and seconds
    let duration = end.diff(start, ['hours', 'minutes', 'seconds']);
    let { hours, minutes, seconds } = duration.toObject();

// Formatting hours, minutes, and seconds
    response.json({
        'duration': `${Math.floor(Math.abs(hours))}h. ${Math.floor(Math.abs(minutes))}m. ${Math.floor(Math.abs(seconds))}s.`
    });

}
);

let port = 3001;
app.listen(3001, () => {console.log(`Listening on port ${port}...`)});
