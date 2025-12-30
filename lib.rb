require 'optparse'

def get_urls
  options = { folder: '.', recursive: true }

  OptionParser.new do |opts|
    opts.on('--folder FOLDER') { options[:folder] = it }
    opts.on('--no-recursive') { options[:recursive] = false }
    opts.on('--recursive') { options[:recursive] = true }
  end.parse!

  glob = options[:folder]
  glob += '/**' if options[:recursive]
  glob += '/urls'

  Dir.glob(glob).flat_map { File.readlines(it).map(&:chomp).grep(/^[^#]/) }
end
