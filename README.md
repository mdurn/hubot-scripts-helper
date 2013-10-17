hubot-scripts-helper
====================

A helper for generating your hubot package.json file with hubot-script dependencies.

##Description

This script creates a package.json file for your heroku-ready hubot build with dependencies
included for your hubot-scripts (no more looking up the dependencies one by one).

1) Copy hubot-scripts-helper.coffee to your hubot directory.

2) Include what scripts you want to use in the hubot-scripts.json file.

3) Save your original 'package.json' file as 'package.json.orig'

4) The script requires node_modules to be compiled in order to parse the scripts (you can delete them afterwards
or gitignore them if desired). Run 'npm install' in your compiled hubot project to install the node_modules.

5) Run in terminal (from your hubot directory):
```bash
coffee hubot-scripts-helper.coffee
```

##Notes

* Make sure you only include scripts in hubot-scripts.json that exist with your version of hubot-scripts!! Look
  at your package.json.orig file to see what version you have and then look up the available scripts in that
  tag version of hubot-scripts on github.

* This adds dependencies based on the dependencies list in script file headers. If a required dependency was not
  listed in the script file, there could still be errors. Make sure to check your Heroku log!

##TODO (desired improvements for this script):

* Remove the need to compile node_modules locally.
* Validate that a corresponding script for the file listed in hubot-scripts.json is found.


![](http://api.mixpanel.com/track/?data=eyJldmVudCI6IlJlcG9zaXRvcnkgVmlld2VkIiwicHJvcGVydGllcyI6eyJ0b2tlbiI6Ijg2YWQ3Mjc5YmQzMGQ2MDMzMzQ0NjYwMDY3YzA1MTg1IiwiY2FtcGFpZ24iOiJodWJvdC1zY3JpcHRzLWhlbHBlciJ9fQ==&ip=1&img=1)
![](http://www.pixelsite.info/track/t19137.gif)
