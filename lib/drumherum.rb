# ruby encoding: utf-8
# ü
if $:.include?(File.dirname(__FILE__))  ||  $:.include?(File.expand_path(File.dirname(__FILE__)))
  #puts 'Path schon aktuell'
else
  $:.unshift(File.dirname(__FILE__)) 
end

require 'hoe'

module Drumherum 

  VERSION = '0.1.0' # Drumherum
  
  
  
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
    
   
   
   
   

    
    
    
  end # moduldefinitionen   
  
end



if $0 == __FILE__ 


  #Drumherum.project_name='kyanite'
  puts Drumherum.project_version

end
  


 
