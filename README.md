NZB
===
[![Gem Version](https://badge.fury.io/rb/nzb.svg)](http://badge.fury.io/rb/nzb)

Simple library used for nzb file creation. If you don't know what nzb file is, you could check wikipedia: http://en.wikipedia.org/wiki/Nzb

It's used in my other project - https://github.com/tdobrovolskij/sanguinews

INSTALLATION
============
Simply invoke gem install:

    gem install nzb

How to use
==========
Methods:
* save_segment - needs to be run for every segment(partial file), replaces write_segment(saves info into a variable)
* write_header - invoked only once to generate xml header
* write_file_header - you need to invoke it once for every file with following parameters:
  - poster - as in from field
  - subject - as in subject field
  - groups - separated by comma if more than one
  - date - optional; unix timestamp required
* write_file_footer - invoked only once for every file; closes file section
* write_segment - needs to be run for every segment(partial file)
  - size - size in bytes
  - number - number of the part
  - msgid - message ID as told by the NNTP server
* write_segments - writes saved segments to a file
* write_footer - closes nzb. Normally you shouldn't write to a file after this method was invoked.

HISTORY
=======
* 0.2.2 - Added save_segment and write_segments methods
* 0.2.1 - Added attr_reader for nzb_filename  
* 0.2.0 - Initial public release
