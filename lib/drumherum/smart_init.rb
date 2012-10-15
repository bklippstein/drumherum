# ruby encoding: utf-8
# ü


module SmartInit 
  
  # Vereinfacht die require-Statements in den Tests bei der Entwicklung von Libraries.  
  # Beim lokalen Aufruf eines einzelnen Tests wird die lokale Version der Library verwendet, nicht die installierte gem.
  # Verwendung:
  #   if $0 == __FILE__ 
  #     require 'drumherum'
  #     smart_init   
  #   end
  #   require 'mygemproject'  
  #
  def smart_init(__file__ = nil)
    __file__ = caller[0] unless __file__
    dir_caller =File.dirname(__file__)
    
    #puts "smart_init " + dir_caller    
    
    patharray = dir_caller.split('/')
    patharray = dir_caller.split("\\")       if patharray.size == 1  
    # libpath = File.join(patharray)   
    patharray.size.times do |i|
      break   if File.directory?( File.join(patharray, 'lib') ) 
      patharray << '..'
    end
    newpath = File.join(patharray,'lib')  
    if $:.include?(newpath)
      return false
    else
      $:.unshift(newpath)  
      return true
    end
    
  end  #def  
  
  
end # module

class Object
  include SmartInit
end


# ---------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ 

# pp RUBYDIR

smart_init
$LOAD_PATH.each do |path|
puts path
end

end










