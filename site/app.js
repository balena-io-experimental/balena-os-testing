const express = require('express')
const app = express()
const path = require('path');
var cmd=require('node-cmd');
const fs = require('fs')

const PORT = process.env.PORT || 8080;
var HEALTHY = true;
const STARTTIME = Date.now()

// Send the displayed page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname + '/index.html'));
})

// Return the status and the time the service has started
app.get('/status', (req, res) => {
    var status = { starttime: STARTTIME }

    if (HEALTHY) {
        status.status = 'OK';
    } else {
        status.status = 'BROKEN';
        res.status(503);
    }
    res.send(status);
})

// Break the service if this endpoint is called
app.get('/break_things', (req, res) => {
    console.log("Got broken...");
    HEALTHY = false;
    res.send('Done, you happy?');
})

app.get('/new-lock', (req, res) => {
    console.log("/new-lock");
 
    cmd.get(
        'lockfile /tmp/balena/updates.lock',
        function(err, data, stderr){
            console.log('locking with /tmp/balena/updates.lock');
            if (err) {
                res.send(500)
            } if(stderr){
                res.send(stderr)
            }else {
                res.send('locked with /tmp/balena/updates.lock');
            }
        }
    );
})

app.get('/old-lock', (req, res) => {
    console.log("/old-lock");
 
    cmd.get(
        'lockfile /tmp/resin/resin-updates.lock',
        function(err, data, stderr){
            console.log('locking with /tmp/resin/resin-updates.lock');
            if (err) {
                res.send(500)
            } if(stderr){
                res.send(stderr)
            }else {
                res.send('locked with /tmp/resin/resin-updates.lock');
            }
        }
    );
})

// Return the status and the time the service has started
app.get('/lock-status', (req, res) => {
    var lockStatus = { status: null }
    const pathOld = '/tmp/resin/resin-updates.lock'
    const pathNew = '/tmp/balena/updates.lock'
    if (fs.existsSync(pathOld)) {
        //file exists
        lockStatus.status = 'locked: old';
    } else if (fs.existsSync(pathNew)) {
        lockStatus.status = 'locked: new'
    } else {
        lockStatus.status = 'unlocked'
    }
    res.send(lockStatus);
})

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Started on port ${PORT}`)
})
