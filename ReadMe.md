A proof of concept Web-based App for exploring haul data.

Use the following R-Script to install and run this App on your local machine. You can copy and paste the code in the R terminal.

```R
if(!require('devtools',quietly=TRUE)) install.packages('devtools')
devtools::install_github("seastateinc/WebApp")
shiny::runGitHub("seastateinc/WebApp")
```
---
