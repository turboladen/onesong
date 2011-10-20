require 'yard'

YARD::Rake::YardocTask.new do |t|
  t.files = %w(lib/**/*.rb - History.rdoc)
  t.options = %w(--title onesong Documentation (#{Onesong::VERSION}))
  t.options += %w(--main README.rdoc)
  t.options += %w(--private --protected --verbose)
end
