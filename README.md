README
================

Overview
--------

bRush is an R client to interface with the Instructure Canvas LMS.

For most functions, bRush returns a data frame. Combining bRush with dplyr makes it quick and easy to subset pesky unknown ID numbers (course, assignment, etc.) for the supplied known name.

As a client for R, bRush makes assumptions on behalf of the user that they are interested in as much data from the requests as possible. As such, unless otherwise specified, requests are recursively processed until all results for a requests have been acheived (if there are 926 courses, bRush will make the call ten times gathering 100 results each time). Additonal, any "include" options are set to true by default.

Canvas API Documentation is available here: <https://canvas.instructure.com/doc/api/index.html>

Installation
------------

Setup API Token
---------------

Example Usage
-------------

### Example One: Get my course ID and make an assigment in that course

``` r
library(bRush)

url <- "https://canvas.instructure.com/"
mycourses <- getMyCourses(url)
courseid <- mycourses$id[mycourses$name == "Introduction to R"]
createAssignment(url, courseid, "Week One Homework")
```

### Example Two: Get a subaccount ID and then get stats for it within a term (id supplied)

``` r
library(bRush)

url <- "https://canvas.instructure.com/"
accounts <- getAccounts(url)
accountid <- accounts$id[accounts$name == "Organizations"]
stats <- getAnalytics(url, accountid, type = "statistics", term = 1111)
```

### Example Three: Use with dplyr for quick access

``` r
library(bRush)
library(dplyr)

url <- "https://canvas.instructure.com/"
accountid <- getAccounts(uri$beta) %>% filter(name == "Organizations") %>% .[["id"]]
```

Status of Project
-----------------

I make use of this package to automate tasks and generate usage reports. Functions are developed as tasks present themselves. I hope that sharing this, others will find value and perhaps contribute functions for their purposes to the package.
