require 'rubygems'

# Need for processing documents
require 'yaml'
require 'haml'

# Webserving, yay!
require 'sinatra'

# Making life easier
require 'ext'



# Pre-compiling (in a sense) all of the people, pages, and projects ahead of time.
# Reducing the hit on the filesystem.
people = []
puts 'Loading People'
Dir['./people/*.{haml,html}'].each do |file|
  people << parse(file)
  puts "\t+ #{file} -> /people/#{people.last[1][:path]}"
end

projects = []
puts 'Loading Projects'
Dir['./projects/*.{haml,html}'].each do |file|
  projects << parse(file)
  puts "\t+ #{file} -> /projects/#{projects.last[1][:path]}"
end

pages = []
puts 'Loading Pages'
Dir['./pages/*.{haml,html}'].each do |file|
  pages << parse(file)
  puts "\t+ #{file} -> /#{pages.last[1][:path]}"
end

print 'Compiling Page Routes... '
pages_match = '('+pages.collect {|p| Regexp.escape(p[1][:path]) }.join('|')+')'
print "Done\n"

puts "\n" # Our reporting is finished; now it's time to let Sinatra take the mic.

before do
  @pages = pages  
end

# Essentially serving up static assets out of memory and the filesystem. Only heaving lifting is routing and the views.
get '/' do
  @people   = people
  @projects = projects
  haml :index
end
get '/people/:path' do
  @person = people.select {|p| p[1][:path] === params[:path]}.first
  if @person
    haml :person
  else
    not_found
  end
end
get '/projects/:path' do
  @project = projects.select {|p| p[1][:path] === params[:path]}.first
  if @project
    haml :project
  else
    not_found
  end
end
get Regexp.new("^/#{pages_match}$", true) do |t|
  @page = pages.select {|p| p[1][:path] === t }.first
  haml :page
end

