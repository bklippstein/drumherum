# ruby encoding: utf-8
# ü

module Drumherum  
   
  
  class << self
    
    def project_name=(pn)
      @project_name = pn
    end
  
  
    # Name of the actual project
    def project_name
      @project_name || 'Drumherum'
    end

    
    # Class of the actual project    
    def project_class
      classname = project_name.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ classname
        raise NameError, "#{classname.inspect} is not a valid constant name!"
      end
      Object.module_eval("::#{$1}", __FILE__, __LINE__)
    end

    # Version of the actual project
    def project_version
      project_class.const_get('VERSION')
    end
    
    
    
    # Set your github username    
    def github_username=(gn)
      @github_username = gn
    end
    
    # Your github username      
    def github_username
      @github_username || 'gleer'
    end    
    
    # Set the main directory (as array)   
    def directory_main=(mn)
      @directory_main = mn
    end    
    
    # The main directory (as array)     
    def directory_main
      @directory_main || []
    end      
        
  end # moduldefinitionen   
  
end


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
    
    Drumherum::directory_main = patharray.dup
       
    # Lib-Pfad anfügen       
    newpath = File.join(patharray,'lib')  
    unless $:.include?(newpath)
      $:.unshift(newpath)  
    end       
       
    # Hauptpfad anfügen   
    newpath = File.join(patharray)  
    unless $:.include?(newpath)
      $:.unshift(newpath)  
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










