#!/usr/bin/ruby

#-----------------------------------------------------------------------------------------------
# genome_coverage
# Copyright (C) 2015 Michael G. Campana
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#-----------------------------------------------------------------------------------------------

#-------------------------------------------------
# Additional Methods
#-------------------------------------------------
def mean(val = [])
	mean = 0.0
    total = 0.0
	for i in 0.. val.size-1
		mean += i * val[i]
        total += val[i]
	end
	mean /= total
	return mean
end
#-------------------------------------------------
def stdev(val = [])
	me = mean(val)
	st = 0.0
    de = 0.0
	for i in 0.. val.size-1
		add = (i - me) * (i - me)
		st += add * val[i]
        de += val[i]
	end
	st /= de
	st2 = Math.sqrt(st)
	return st2
end
#-------------------------------------------------
begin
    print "File name?\n"
    filename = gets.chomp
    while !FileTest.exist?(filename)
        print "File not found. Re-enter.\n"
        filename = gets.chomp
    end
    print "Enter output histogram name.\n"
    outname = gets.chomp
    histogram = [0]
    linecount = 0
    counter = 0
    File.open(filename, 'r') do |f1|
        while line = f1.gets
            counter += 1
            start = ""
            final = ""
            tabs = 0
            coverage = ""
            line.delete!("\n")
            line.gsub!("\t", "%")
            for l in 0...line.length
                tabs += 1 if line[l].chr == "%"
                start += line[l].chr if tabs == 1
                final += line[l].chr if tabs == 2
                coverage += line[l].chr if tabs == 3
            end
            start.delete!("%")
            final.delete!("%")
            coverage.delete!("%")
            sites = final.to_i - start.to_i
            if coverage.to_i > histogram.size - 1
                for k in histogram.size - 1 .. coverage.to_i - 1
                    histogram.push(0)
                end
            end
            histogram[coverage.to_i] += sites
            if counter == 1000000
                counter = 0
                linecount += 1000000
                print "Processed " + linecount.to_s + " lines.\n"
            end
        end
    end
    out = ""
    for i in 0...histogram.size
        out += i.to_s + "\t" + histogram[i].to_s + "\n"
    end
    print "Mean: " + mean(histogram).to_s + "\tStDev: "  +  stdev(histogram).to_s
    File.open(outname, 'w') do |f2|
        f2.puts out
    end
end