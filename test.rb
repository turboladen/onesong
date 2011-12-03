require 'observer'

class SongList
  include Observable

  def initialize(path)
    @path = File.expand_path path
    @files = Dir.glob("#{@path}/**/*")
    add_observer Tracker.new
  end

  def find_copied_files
    files = @files.dup

    files.each do |original_file|
      #files.delete original_file

      files.each do |compared_file|
        next if original_file.length >= compared_file.length
        original_ext = File.extname original_file
        compared_ext = File.extname compared_file

        next if original_ext != compared_ext

        #puts "original file: #{original_file}"
        #puts "compared file: #{compared_file}"
        ofile = File.basename original_file, original_ext
        cfile = File.basename compared_file, compared_ext
        #puts "original file base: #{ofile}"
        #puts "compared file base: #{cfile}"
        
        if cfile =~ /#{ofile}/
          changed
          notify_observers :copied_file, compared_file
        end
      end
    end
  end
end

class Tracker
  def update(error_type, bad_file)
    puts "Problem: #{error_type}"
    puts "File:    #{bad_file}"
  end
end


puts "Check dir: #{ARGV.first}"
s = SongList.new ARGV[0]
s.find_copied_files
