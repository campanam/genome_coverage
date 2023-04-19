#!/usr/bin/ruby

#-----------------------------------------------------------------------------------------------
# genome_coverage v0.2.0
# Michael G. Campana, 2015-2023
# Smithsonian Conservation Biology Institute
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
	if ARGV[0].nil?
    	print "File name?\n"
    	filename = gets.chomp
    else
    	filename = ARGV[0]
    end
    while !FileTest.exist?(filename)
        print "File not found. Re-enter.\n"
        filename = gets.chomp
    end
    if ARGV[1].nil?
    	print "Enter output histogram name.\n"
    	outname = gets.chomp
    else
    	outname = ARGV[1]
    end
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
                $STDERR.puts "Processed " + linecount.to_s + " lines.\n"
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
