# version

[![Build Status](https://travis-ci.com/wkusnierczyk/version.svg?token=b9xxBNxAZz3Wuv8J8CAj&branch=master)](https://travis-ci.com/wkusnierczyk/version)

`version` is a simple utility to handle incremental version numbers of the form `MAJOR.MINOR.PATCH` (or `MAJOR.MINOR.BUILD`), as discussed in [Semantic Versioning 2.0.0](http://semver.org).

 
## Installation
 
There is none.  The code is contained in the script file `src/version.sh`, and can be used in two ways:

* as an executable:  
`./version.sh [ args ]`
* as a function sourced from the script file:  
`. ./version.sh && version [ args ]`


The arguments `args` differ between the two versions. 

## Execution

The script execution takes as arguments the current version string and a flag specifying the part of the version string to update.
Each flag has a long and a short version:
```bash
./version.sh --build 0.0.0
./version.sh -b 0.0.0
# 0.0.1

./version.sh --minor 0.0.0
./version.sh -i 0.0.0
# 0.1.0

./version.sh --major 0.0.0
./version.sh -a 0.0.0
# 1.0.0
```

The part flag is optional and defaults to `--build` (or `-b`):

```bash
./version.sh 0.0.0
# 0.0.1
```

The sourced function accepts the part specification as an optional second argument rather than a flag (and does not have a short form):
```bash
. ./version.sh
version 0.0.0 minor
# 0.1.0
```
