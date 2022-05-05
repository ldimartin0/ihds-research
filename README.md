# Gender Inequality in India - India Human Development Survey

This is the repository for my project on economic gender inequality for INAF-383, Applied Econometrics for Development.

## Data
The data are available [here](https://www.icpsr.umich.edu/web/ICPSR/studies/37382). The data are large enough that I am not storing them on GitHub. I am studying the individual appended long panel. They are stored in a `data` subfolder that isn't listed on GitHub.

### Cleaning Procedure
This is the procedure to replicate the data cleaning. Note that it must be followed in order. Each scripts stores a new data object to preserve total transparency into the cleaning process.


1. Download and store the appended individual long panel data as `data/indiv-appended-panel.dta`.
2. Use `scripts/compress.do` to create a new compressed version for memory efficiency. If you do not require it, the original data can be deleted.
3. Use `scripts/data.do` to rename variables for easier programming.
4. Use `scripts/clean_for_regression.do` to drop necessary observations (e.g. those missing response variable data).

## Paper
The paper is stored in the `paper` subfolder.
