sido
======

Simple download counter

The goal of this project is to create a way to count downloads easily and to create report.

Sido is multi project and multi version by project.

Sido manage event by project.

Sido used [Sinatra](http://sinatrarb.com), [Sequel](http://sequel.rubyforge.org), [Haml](http://haml-lang.com), [Tipsy](https://github.com/jaz303/tipsy), [tableshorter](http://tablesorter.com), [jquerydate](http://www.kelvinluck.com/assets/jquery/datePicker/v2/demo/) and [Flot](http://code.google.com/p/flot/).

It's inspired by [cijoe](https://github.com/defunkt/cijoe). 

Requierement
------------

* [Sinatra](http://sinatrarb.com)
* [Haml](http://haml-lang.com)
* [Sequel](http://sequel.rubyforge.org)

Installation
------------

**tipsy**

Download tipsy from https://github.com/jaz303/tipsy and put tipsy/src in ./public/js/tipsy

**flot**

Download flot from http://code.google.com/p/flot/downloads/list and put *.js in ./public/js/flot 
 
**tablesorter**

Download jquery.tablesorter.min.js from http://tablesorter.com/docs/#Download and put it in ./public/js/tablesorter

Download asc.gif, bg.gif, desc.gif from http://tablesorter.com/themes/green/green.zip and put it in ./plublic/img/ 

**jquerydate**

Download jquery.datePicker.js from http://www.kelvinluck.com/assets/jquery/datePicker/v2/demo/ and put it in ./public/js/jquerydate

Download datePicker.css from http://www.kelvinluck.com/assets/jquery/datePicker/v2/demo/ and put it in ./public/css

Download date.js from https://github.com/vitch/jquery-methods and put it in ./public/js/jquerydate

Use
---

**How to track download :**

Add sido.js : 

    <script type="text/javascript" src="js/sido.js"></script>
Modify Sido_Server in sido.js to match the url of your sido server.

Put onclick method on your download link like that : 

    <a href="./flot-0.7.zip" onclick="javascript:track('project_one','nightly')">test</a>
**How to add an event programmatly :**

Add sido.js : 

    <script type="text/javascript" src="js/sido.js"></script>
Modify Sido_Server in sido.js to match the url of your sido server.

Call add_event('project_one', 'beta test compaign begin')

**One project**
![One project](http://f.cl.ly/items/1Y3E2C02152c0r2v2V03/Sido%20-%20Simple%20Download%20Tracker_1310303203863.png)

TODO
----

* Create an install script.
* Add auto refresh (ajax + pusher).

Copyright/License
-----------------

Copyright (c) 2011 Antoine Froissart under the MIT License. See LICENSE for details.
