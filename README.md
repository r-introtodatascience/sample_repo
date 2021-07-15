# Rcourse

This repository was created by [Joseph M. Westenberg](https://github.com/jmwestenberg) to go along with notes at <https://r-introtodatascience.github.io/index.html>. This was a 5 session workshop created to provide an introduction to R. In particular I designed these workshops around commands I have used most in data cleaning/wrangling for research.

## General Structure for repository
The overall goal for this structure is to help us organize where our inputs and outputs go. The logic for this structure was thought of through a simplification of the structure in <https://econ-project-templates.readthedocs.io/en/stable/index.html>

### Parent folder

- workingdir.r : has variables for paths to other folders predefined. These variables are then read in to all scripts. The names of these variables are supposed to map directly into the folders. In summary we define the following variable names:
  - folder_figures: variable for path to figures folder
  - folder_processed_data: variable for path to processed data folder
  - folder_raw_data: variable for path to raw_data folder
  - folder_scripts: variable for path to scripts folder 
  - folder_tables: variable for path to tables folder
  - folder_tex: variable for path to tex folder

Note: you will have to change paths in each script to be consistent with the paths to your main working directory folder.

### figures
Any graphics/png files we have our scripts create are stored in this folder.

### processed_data
Any data we have cleaned or manipulated at all is stored in this folder.

### raw_data
Where we have our original data stored. This data (ideally) should be absolutely untouched by us. The only thing we do to it is read it into scripts to clean/process. The processed data is then stored in the processed_data folder.

### scripts
Where any scripts we have written go. Depending on the complexity of your project, it may be worth breaking this into different sub-folders (ie. data cleaning scripts, analysis scripts, plotting scripts, etc)

### tables
Any tables we have generated with our scripts will be saved here. The ideal case for us will be to save them as tex files, so they can be read directly into our paper.

### tex
This is where we will hold our files for our paper, presentations, work log, etc. 


