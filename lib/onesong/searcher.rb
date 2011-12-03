require 'observer'

=begin
module Onesong
  class Searcher
    def initialize(music_path)
      @path = File.expand_path music_path
    end

    def duplicate_files
      dupes = []
      entries = Dir.glob("#{@path}/**/*")
      entries.each do |entry|
        entries.delete(entry)
        entries.each do |e|
          if File.basename(e) == File.basename(entry)
            #dupes << "#{e} is a dupe of #{entry}"
            puts "#{e} is a dupe of #{entry}"
          end
        end
      end

      puts "dupes", dupes
      dupes
    end
  end
end
=end
module Onesong
  class Searcher
    def initialize(music_path)
      @path = File.expand_path music_path
    end

  end
end


class Notifier
  def initialize(searcher)
    searcher.add_observer(self)
  end
end

class FileCopiedNotifier
  def update(source, target)
    @source = source
    @target = target

    if files_match?
      puts "--- files match:"
      puts "\t#{@source}"
      puts "\t#{@target}"
    end
  end

  def files_match?
    @target.basename =~ /#{@source.basename} \d/
  end
end
