# taxizehelper 0.3.0

- FIX - `get_level()` now parses names that have hypens (e.g. *Athyrium austro-occidentale*).
- MOD - `get_level()` now accepts full-stops, hyphens, and brackets in names. 

# taxizehelper 0.2.0

- ADD - `search_gnr()` now returns a dataframe of the same length as your species list. This lets you do things like copy a list of species from a spreadsheet, identify them, and then use `writeClipboard(search_gnr_results$family)` to copy the `family` column and paste it back into your spreadsheet. Note that `search_gnr()` runs `unique()` on the list so that it doesn't look up the same species 30 times.

# taxizehelper 0.1.0

- First commit.
- ADD -`NEWS.md` file to track changes to the package.



