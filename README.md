hubot-scripts-helper
====================

A helper for generating your hubot package.json file with hubot-script dependencies.

##Description

This script creates a package.json file for your heroku-ready hubot build with dependencies
included for your hubot-scripts (no more looking up the dependencies one by one).

1) Include what scripts you want to use in the hubot-scripts.json file.

2) Save your original 'package.json' file as 'package.json.orig'

3) The script requires node_modules to be compiled in order to parse the scripts (you can delete them afterwards
or gitignore them if desired). Run 'npm install' in your compiled hubot project to install the node_modules.

##Notes

* Make sure you only include scripts in hubot-scripts.json that exist with your version of hubot-scripts!! Look
  at your package.json.orig file to see what version you have and then look up the available scripts in that
  tag version of hubot-scripts on github.

* This adds dependencies based on the dependencies list in script file headers. If a required dependency was not
  listed in the script file, there could still be errors. Make sure to check your Heroku log!

##TODO (desired improvements for this script):

* Remove the need to compile node_modules locally.
* Validate that a corresponding script for the file listed in hubot-scripts.json is found.
