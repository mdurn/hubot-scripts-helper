#!/usr/bin/env coffee
# -*- mode:coffee -*-
# 
# This script creates a package.json file for your heroku-ready hubot build with dependencies
# included for your hubot-scripts (no more looking up the dependencies one by one).
#
# 1) Include what scripts you want to use in the hubot-scripts.json file.
#
# 2) Save your original 'package.json' file as 'package.json.orig'
#
# 3) The script requires node_modules to be compiled in order to parse the scripts (you can delete them afterwards
# or gitignore them if desired). Run 'npm install' in your compiled hubot project to install the node_modules.
#
# Note: Make sure you only include scripts in hubot-scripts.json that exist with your version of hubot-scripts!! Look
#       at your package.json.orig file to see what version you have and then look up the available scripts in that
#       tag version of hubot-scripts on github.

# requirements
fs = require('fs')
rl = require('readline')


# vars
dependencies = {}
scriptCount = 0
scriptsRead = 0


# functions

mergeDependencies = (deps1, deps2) ->
  deps = {}
  for k,v of deps1
    deps[k] = v
  for k,v of deps2
    deps[k] = v
  deps

createPackageFile = ->
  fs.readFile 'package.json.orig', (err, data) ->
    if err then throw err

    packageJson = JSON.parse(data)
    packageJson['dependencies'] = mergeDependencies(packageJson['dependencies'], dependencies)

    packageStr = JSON.stringify(packageJson, null, 2)
    fs.writeFile('package.json', packageStr, ->
      console.log('Successfully created package.json')
    )

parseScripts = (scriptList) ->
  for script in scriptList
    dependencyLine = false
    scriptStream = fs.createReadStream("node_modules/hubot-scripts/src/scripts/#{script}")
    scriptReader = rl.createInterface
      input: scriptStream
      output: process.stdout
      terminal: false

    scriptReader.on('line', (line) ->
      if /#\s*Dependencies:/.test(line)
        dependencyLine = true
      else if dependencyLine
        if (/None/.test(line) || /^#\s*$/.test(line))
          dependencyLine = false
        else if dependencyLine
          dependency = line.match(/".+"?:\s+".+"/g) # "? to account for malformatted dependencies
          return unless dependency?

          dep_pairs = dependency[0].replace(/"/g, '').split(': ')
          if dependencies[dep_pairs[0]]?
            dependencies[dep_pairs[0]] =
              if dependencies[dep_pairs[0]] > dep_pairs[1] then dependencies[dep_pairs[0]] else dep_pairs[1]
          else
            dependencies[dep_pairs[0]] = dep_pairs[1]
    ).on('close', ->
      scriptsRead++
      if scriptsRead == scriptCount
        createPackageFile()
    )

main = ->
  fs.readFile 'hubot-scripts.json', (err, data) ->
    if err then throw err
    scriptsList = JSON.parse(data)
    scriptCount = scriptsList.length
    parseScripts(scriptsList)


# main
main()


