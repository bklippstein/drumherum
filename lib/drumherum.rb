# ruby encoding: utf-8
# ü


require 'hoe'
require 'rbconfig'
require 'drumherum/smart_init' unless defined? SmartInit




unless defined? WINDOWS  
  WINDOWS = /djgpp|(cyg|ms|bcc)win|mingw/ =~ RUBY_PLATFORM ? RUBY_PLATFORM : false       
end

unless defined? RUBYDIR
  RUBYDIR = RbConfig::CONFIG['prefix']
  # puts "rubydir=" + RUBYDIR
end








if $0 == __FILE__ 


  puts Drumherum.project_version
  
  smart_init(__FILE__)
  $LOAD_PATH.each do |path|
  puts path
  end  

end
  


 
