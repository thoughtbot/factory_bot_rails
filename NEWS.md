factory_bot_rails versioning is synced with factory_bot releases. For this reason
there might not be any notable changes in new versions of this project.

# NEWS

## 5.0.1
  Bugfix: Avoid watching files and directories that don't exist (to avoid a
  file watching bug in Rails https://github.com/rails/rails/issues/32700)

## 5.0.0
  Added: calling reload! in the Rails console will reload any factory definition files that have changed
  Added: support for custom generator templates
  Added: definition_file_paths configuration option, making it easier to place factories in custom locations
  Changed: namespaced models are now generated inside a directory matching the namespace
  Changed: added newline between factories generated into the same file
  Removed: support for EOL version of Ruby and Rails

## 4.11.1 (September 7, 2018)
  Update generator to use dynamic attributes instead of deprecated static attributes

## 4.11.0 (August 16, 2018)
  No notable changes

## 4.10.0 (May 25, 2018)
  No notable changes

## 4.8.2 (October 20, 2017)
  Rename factory_girl_rails to factory_bot_rails

## 4.7.0 (April 1, 2016)
  No notable changes

## 4.6.0 (February 1, 2016)
  No notable changes

## 4.5.0 (October 17, 2014)
  Improved README

## 4.4.1 (February 26, 2014)
  Support Spring

## 4.2.1 (February 8, 2013)
  Fix bug when configuring FG and RSpec fixture directory
  Remove debugging
  Require factory_girl_rails explicitly in generator

## 4.2.0 (January 25, 2013)
  Add appraisal and get test suite working reliably with turn gem
  Support MiniTest
  Allow a custom directory for factories to be specified
