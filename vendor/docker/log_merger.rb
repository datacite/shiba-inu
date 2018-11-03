
require 'date'
require 'pathname'


class ResolutionLogsMerger

  FILE_STEM = "DataCite-access.log"

  def self.get_date filename
    directory = Pathname(filename).basename.to_s 
    puts filename
    puts directory
    Date.parse("#{directory}01")
  end

  def self.merge_logs 
    @log_date = get_date ARGV[0]
    @folder = ARGV[0]
    puts @log_date
    uncompress_files
    add_bookends
    merge_files
    sort_files
  end

  def self.uncompress_files
    system("gunzip #{@folder}/#{FILE_STEM}-*")
  end

  def self.add_bookends
    File.delete("#{@folder}/#{FILE_STEM}-1-begin.log") if File.exist?("#{@folder}/#{FILE_STEM}-1-begin.log")
    File.delete("#{@folder}/#{FILE_STEM}-9-eof.log") if File.exist?("#{@folder}/#{FILE_STEM}-9-eof.log")

    begin_date = Date.civil(@log_date.year,@log_date.month,1).strftime("%Y-%m-%d")
    end_date   = Date.civil(@log_date.year,@log_date.month+1, 1).strftime("%Y-%m-%d") 

    begin_line = '0.0.0.0 BEGIN "'+begin_date+' 00:00:00.000Z" 1 1 22ms 10.5281/zenodo.1043571 "300:10.admin/codata" "" "Mozilla"'+"\n"
    puts begin_line

    end_line = '0.0.0.0 EOF "'+end_date+' 00:01:00.000Z" 1 1 22ms 10.5281/zenodo.1043571 "300:10.admin/codata" "" "Mozilla"'+"\n"
    puts end_line

    File.open("#{@folder}/#{FILE_STEM}-1-begin.log","w") {|f| f.write(begin_line) }
    File.open("#{@folder}/#{FILE_STEM}-9-eof.log","w") {|f| f.write(end_line) }
  end

  def self.merged_file
    "#{@folder}/datacite_resolution_logs_#{@log_date}.log"
  end

  def self.sorted_file
    "#{@folder}/datacite_resolution_logs_#{@log_date}_sorted.log"
  end

  def self.file_steam
    file
  end

  def self.merge_files
    File.delete(merged_file) if File.exist?(merged_file)

    system("cat #{@folder}/#{FILE_STEM}-* > #{merged_file}")
    puts "Merged Completed"
  end

  def self.sort_files
    File.delete(sorted_file) if File.exist?(sorted_file)

    system("sort -k3 #{merged_file} > #{sorted_file}")
    puts "Sorted Completed"
  end

end

ResolutionLogsMerger.merge_logs 