<!--- Provide a general summary of your changes in the Title above -->
Added functionality to upload files to PasswordState
## Description
<!--- Describe your changes in detail -->
Changes were made to New-PasswordStatePassword to allow Documents to be uploaded.
This included creating multiple new Parametersets.

I also created a new function called Set-PasswordStateDocument, which allows you to upload a file to an existing Password or Passwordlist

I updated to help to reflect the changes I made

I have also made changes to Readme.md, since I had several colleagues who had issues figuring out how the module to work, so I adding an getting started guide, and added multiple examples for the new functionality.

## Related Issue
<!--- This project only accepts pull requests related to open issues -->
<!--- If suggesting a new feature or change, please discuss it in an issue first -->
<!--- If fixing a bug, there should be an issue describing it with steps to reproduce -->
<!--- Please link to the issue here: -->

I have not opened a issue, I can do so if you prefer

## Motivation and Context
<!--- Why is this change required? What problem does it solve? -->

I had a need to upload certificate files to be stored in Passwordstate, and had several 100's, and did not care to do that by hand

## How Has This Been Tested?
<!--- Please describe in detail how you tested your changes. -->
<!--- Include details of your testing environment, and the tests you ran to -->
<!--- see how your change affects other areas of the code, etc. -->

I have not written any Pester tests to test the actual code, but have run all existing Pester tests.
 
I have tested all the different combinations of commands that I could think of in regards to New-PasswordStatePassword and Set-PasswordStateDocument.

The code changes are limited to the 2 above mentioned functions, and should not have an impact on existing functionality in other functions.

It has been tested on Windows 10 with PowerShell version 5.1.14393.0

## Screenshots (if appropriate):

## Types of changes
<!--- What types of changes does your code introduce? Put an `x` in all the boxes that apply: -->
- [ ] Bug fix (non-breaking change which fixes an issue)
- [x] New feature (non-breaking change which adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to change)

## Checklist:
<!--- Go over all the following points, and put an `x` in all the boxes that apply. -->
<!--- If you're unsure about any of these, don't hesitate to ask. We're here to help! -->
- [x] My code follows the code style of this project.
- [x] My change requires a change to the documentation.
- [x] I have updated the documentation accordingly.
- [x] I have read the **CONTRIBUTING** document.
- [ ] I have added tests to cover my changes.
- [x] All new and existing tests passed.
