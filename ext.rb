class Hash
  def symbolize
    accum = {}
    self.each {|k, v| accum[k.to_sym] = v }
    accum
  end
end

def parse(file)
  # Parses a file; grabs YAML out of the header as well as the rest of the document.
  # Tries to guess format and pre-renders if it can figure it out.
  
  contents = File.read(file) {|f| f.read }
  parts    = contents.split(/^---\s*\n(.+)\s*\n---\n/m) # Pull out the YAML header
  # https://github.com/mojombo/jekyll/blob/master/lib/jekyll/convertible.rb line 26 for YAML header parsing inspiration.
  # Build a response in the format: [file path, options from YAML header, raw data after the header]
  if parts.length > 2 # If the header is found.
    resp = [file, YAML::load(parts[1]).symbolize, parts[2]]
  else
    resp = [file, {}, parts[0]]
  end
  
  # Build a scope of options from the header
  scope = Object.new
  resp[1].each do |k, v|
    scope.instance_variable_set("@#{k}".to_sym, v)
  end
  # Guess the format.
  if resp[0] =~ /haml$/
    resp[2] = Haml::Engine.new(resp[2]).render scope # Render the raw data with the scope
  end
  
  resp[1][:path] = File.basename(resp[0]).split('.').first unless resp[1].has_key? :path
  
  resp
end