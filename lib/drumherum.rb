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



  


 
