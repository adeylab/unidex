# unidex
universal demultiplexer for Adey/ORoak ops

To set up, create a line in the config file for your application. Details are in the header for the file.

Unidex options:

UNIDEX (Universal Demultiplexer, v0.210607-test1)

Usage:

unidex [options]

Info Options:
  -L          List modes present in the mode config file (def = /home/groups/oroaklab/demultiplex/unidex_modes.cfg)
              Can specifiy a different mode file with -m and it will list modes in that file.
  -I  [MODE]  Provide info on one or more comma separated modes as detailed in the specified
              modes file (-m or default).

Run Options:
  -R  [STR]   Run Folder (where fastq files are present)
  -M  [LIST]  Mode list - modes must be specified in the modes.cfg file (/home/groups/oroaklab/demultiplex/unidex_modes.cfg)
              Modes must be comma separated and will demultiplex in specified order listed.

Default Options:
  -O  [STR]   Output folder (def = run name, -R)
  -d  [INT]   Max allowed hamming distance (def = 2)

Default Locations:
  -r  [PATH]  Fastq folder full path (def = /home/groups/oroaklab/fastq)
  -o  [PATH]  Output folder (def = /home/groups/oroaklab/demultiplex)
  -m  [STR]   Mode config file (def = /home/groups/oroaklab/demultiplex/unidex_modes.cfg)

Fastq Input (default = auto detect):
  -1  [STR]   Read 1 fastq
  -2  [STR]   Index 1 fastq
  -3  [STR]   Index 2 fastq
  -4  [STR]   Read 2 fastq

Other Options:
  -A  [STR]   Annotation file(s), comma separated with mode specified
              If only one mode is specified, then it will default to that mode
              [mode1]=[annot_file1],[mode2]=[annot_file2],etc... OR
                          First column of annot file designates mode for thast annot
  -u          Only report a read to the first mode that it matches (def = all)
  -g  [STR]   Gzip command (def = gzip)
  -z  [STR]   Zcat command (def = zcat)
  -V          Verbose / debug mode (outputs to STDERR)
