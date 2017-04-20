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

bRush is not available on CRAN and can be installed directly from GitHub using the devtools package (which is available on CRAN).

``` r
devtools::install_github("erikpal/bRush")
```

Setup and use of API Token
--------------------------

To use this package, create an access token in Canvas by going to Account &gt; Settings &gt; Approved Integrations &gt; + New Access Token. I recommend not setting an expiration date.

Place the token in a file called .Renviron as such:

``` r
CanvasApiKey = 7~ABcD123efG45hIJ78KLMno9PQrstuVwXyZ10
```

This method follows the best practice for developing API packages as documented here: <https://cran.r-project.org/web/packages/httr/vignettes/api-packages.html>

Alternatively, you may place the token in a text file called token.txt to be loaded from the working directory at the time needed.

You may store multiple keys for multiple servers, and override the default name of "CanvasApiKey" by passing this arugument when making requests:

``` r
env_var_name = "NameOfApiKey"
```

The token management options are designed to give you flexibility in moving across installations. Note that keys created in production will be copied over to test and beta environments at their next scheduled copy, which makes it easier to work with a single key.

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

### Example Two: Get a subaccount ID and then get stats for it within a term (term id 1234 supplied)

``` r
library(bRush)

url <- "https://canvas.instructure.com/"
accounts <- getAccounts(url)
accountid <- accounts$id[accounts$name == "Science Department"]
stats <- getAnalytics(url, accountid, type = "statistics", term = 1234)
```

### Example Three: Use with dplyr for quick access

``` r
library(bRush)
library(dplyr)

url <- "https://canvas.instructure.com/"
accountid <- getAccounts(url) %>% filter(name == "Science Department") %>% .[["id"]]
```

Status of Project
-----------------

I make use of this package to automate tasks and generate usage reports. Functions are developed as tasks present themselves. I hope that sharing this, others will find value and perhaps contribute functions for their purposes to the package.
