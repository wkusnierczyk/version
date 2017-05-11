# version

[![Build Status](https://travis-ci.com/wkusnierczyk/version.svg?token=b9xxBNxAZz3Wuv8J8CAj&branch=master)](https://travis-ci.com/wkusnierczyk/version)

`version` is a simple utility to handle incremental version numbers of the form `MAJOR.MINOR.PATCH` (or `MAJOR.MINOR.BUILD`), as discussed in [Semantic Versioning 2.0.0](http://semver.org).

 
## Installation
 
There is none.  The code is contained in the script file `src/version.sh`, and can be used in two wasy:

* as an executable:  
`./src/version.sh [ args ]`
* as a function sourced from the script file:  
`. ./src/version.sh && version [ args ]`


The arguments `args` differ between the two versions. 

## Execution

