# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## 1.4.0 (Unreleased)

## 1.3.0 (2018-03-21)

### Added

- PR10 - Add support for excluding passwords in Get-PasswordStateListPasswords function. (via [@boojew](https://github.com/boojew))

## 1.2.3 (2017-07-19)

### Added

- PR8 - Added support for PowerShell Core by using new method in Invoke-RestMethod to skip certificate checking.
Existing method (using C#) is still in place for PowerShell 5.x and below. (via @ephos)

## 1.2.2 (2016-10-11)

### Fixed

- Fixed bug in New-PasswordStatePassword not returning newly created password

## 1.2.1 (2016-08-23)

### Fixed

- Fixed bug in New-PasswordStatePassword when trying to display -WhatIf message when a document is not being uploaded

## 1.2.0 (2016-07-26)

### Added

- Added option to upload file to New-PasswordStatePassword

- Added new function to upload document (New-PasswordStateDocument)

### Fixed

- Fixed searching by username in Find-PasswordStatePassword

## 1.1.0 (2016-07-17)

### Added

- Add pipeline scripts

- Add additional Pester tests

### Changed

- Refactor module layout
