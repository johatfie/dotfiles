%w{rubygems wirble pp irb/completion irb/ext/save-history}.each do |lib|
  begin
    require lib
  rescue LoadError => err
    $stderr.puts "Couldn't load #{lib}: #{err}"
  end
end

AwesomePrint.irb! if defined?(AwesomePrint)

def load_project_irbrc(path)
    return if (path == ENV["HOME"]) || (path == '/')
    load_project_irbrc(File.dirname path)
    irbrc = File.join(path, '.irbrc')
    load irbrc if File.exists?(irbrc)
end

load_project_irbrc Dir.pwd

#IRB.conf[:USE_READLINE] = true


#history
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

### USEFUL ALIASES
alias q exit

wirble_opts = {
  # don't set the prompt
  :skip_prompt    => true,

  # enable color
  :init_color     => true,
}

# initialize wirble with options above
Wirble.init(wirble_opts)


# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

