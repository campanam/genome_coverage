# genome_coverage
## Michael G. Campana, 2015-2023  

Script to calculate genome sequencing coverage (mean +- standard deviation) from a BEDGRAPH (bga). Outputs a coverage histogram so that highly covered areas can be identified.  

### License  
The software is made available under the Smithsonian Institution [terms of use](https://wwww.si.edu/termsofuse).  

### Installation  
Enter the commands:  
`git clone https://github.com/campanam/genome_coverage/`  
`chmod +x genome_coverage.rb`  
`[sudo] mv genome_coverage.rb [DESTINATION]`  

### Execution  
The script can be executed either interactively or using command-line arguments.  

To run the script interactively, enter the command:  
`ruby genome_coverage.rb`
Give input file name and output histogram name at the prompts. Coverage histogram will be written to the given output name. Genome coverage values will be printed to standard output.  

To run the script using arguments, enter the command:  
`ruby genome_coverage.rb <file.bga> <output.hist>`  
where file.bga being the input bedgraph file and output.hist being the output histogram. If either of these files are missing, the program will prompt you to correct the value interactively.  