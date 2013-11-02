########################################################################
# nzb - class used to generated nzb files according to nzb specs
# Copyright (c) 2013, Tadeus Dobrovolskij
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
########################################################################
# = Methods
# * write_header - invoked only once to generate xml header
# * write_file_header - you need to invoke it once for every file with following parameters:
#   - poster - as in from field
#   - subject - as in subject field
#   - groups - separated by comma if more than one
#   - date - optional; unix timestamp required
# * write_file_footer - invoked only once for every file; closes file section
# * write_segment - needs to be run for every segment(partial file)
#   - size - size in bytes
#   - number - number of the part
#   - msgid - message ID as told by the NNTP server
# * write_footer - closes nzb. Normally you shouldn't write to a file after this method was invoked.
########################################################################
require 'cgi'

class Nzb
  # we accept basename and prefix, combine them and add suffix ".nzb"
  def initialize(filename,prefix='')
    @nzb_filename = prefix + filename + ".nzb"
  end

  # nzb header
  def write_header(name=nil)
    begin
      f = File.open(@nzb_filename,"w+:ISO-8859-1")
    rescue
      raise "Unable to open #{@nzb_filename} for writing."
    end
    f.puts '<?xml version="1.0" encoding="iso-8859-1" ?>'
    f.puts '<!DOCTYPE nzb PUBLIC "-//newzBin//DTD NZB 1.0//EN" "http://www.nzbindex.com/nzb-1.0.dtd">'
    f.puts '<nzb xmlns="http://www.newzbin.com/DTD/2003/nzb">'
    if !name.nil?
      f.puts '  <head>'
      f.puts '    <meta type="title">' + name + '</meta>'
      f.puts '  </head>'
    end
    f.close
  end

  # date must be in unix timestamp or nil(it isn't checked anyway, so whatever)
  def write_file_header(poster,subject,groups,date=nil)
    begin
      f = File.open(@nzb_filename,"a:ISO-8859-1")
    rescue
      raise "Unable to open #{@nzb_filename} for writing."
    end
    from = CGI.escapeHTML(poster)
    subj = CGI.escapeHTML(subject)
    date = Time.now.to_i if date.nil?
    f.puts "<file poster=\"#{from}\" date=\"#{date}\" subject=\"#{subj}\">"
    f.puts '<groups>'
    groups.split(',').each do |group|
      f.puts '<group>' + group.strip + '</group>'
    end
    f.puts '</groups>'
    f.puts '<segments>'
    f.close
  end

  # method closes file section
  def write_file_footer
    begin
      f = File.open(@nzb_filename,"a:ISO-8859-1")
    rescue
      raise "Unable to open #{@nzb_filename} for writing."
    end
    f.puts '</segments>'
    f.puts '</file>'
    f.close
  end

  def write_segment(size,number,msgid)
    begin
      f = File.open(@nzb_filename,"a:ISO-8859-1")
    rescue
      raise "Unable to open #{@nzb_filename} for writing."
    end
    f.puts "<segment bytes=\"#{size}\" number=\"#{number}\">#{msgid}</segment>"
    f.close
  end

  # close nzb
  def write_footer
    begin
      f = File.open(@nzb_filename,"a:ISO-8859-1")
    rescue
      raise "Unable to open #{@nzb_filename} for writing."
    end
    f.puts '</nzb>'
    f.close
  end
end
