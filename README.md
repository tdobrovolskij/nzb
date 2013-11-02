NZB
===

Simple library used for nzb file creation. If you don't know what nzb file is, you could check wikipedia: http://en.wikipedia.org/wiki/Nzb

It's used in my other project - https://github.com/tdobrovolskij/sanguinews

INSTALLATION
============
Simply invoke gem install:

    gem install nzb

How to use
==========
Methods:
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
* write_footer - closes nzb. Normally you shouldn't write to a file after this method was invoked.

HISTORY
=======
* 0.2.0 - Initial public release
