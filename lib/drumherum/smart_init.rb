# ruby encoding: utf-8
#
# 
# You set up your release info once in your Rakefile. Like this:
#   require 'drumherum'
#   smart_init
#   require 'version' 
#   require 'yard'
#   require 'drumherum/rake'
#   YARD::Rake::YardocTask.new
#   Drumherum.github_username = 'your_user_name'
#
# {SmartInit#smart_init smart_init} detects your root directory and sets up the projectname and all other stuff. 
#
module Drumherum  
   
  
  class << self
  
    # @!group Set this up in your Rakefile
    
    # @return [void] Set your github username    
    def github_username=(your_user_name)
      @github_username = your_user_name
    end

    
    # @!group Release infos for DRY release automation
     
    # @return [String] Name of the actual project
    def project_name
      if @directory_main
        @directory_main[-1].strip
      else
        raise "start smart_init first"
      end
    end

    
    # @return [Class] Class of the actual project    
    def project_class
      classname = project_name.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
      unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ classname
        raise NameError, "#{classname.inspect} is not a valid constant name!"
      end
      Object.module_eval("::#{$1}", __FILE__, __LINE__)
    end

    # @return [String] Version of the actual project
    def project_version
      project_class.const_get('VERSION')
    end
    
    
    

    
    # @return [String] Your github username  
    # (see #github_username=)
    def github_username
      @github_username || 'gleer'
    end    
    
    # @return [void] Set the main directory (as array)   
    # @private
    def directory_main=(mn)
      @directory_main = mn
    end    
    
    # The root directory of your project (as array).
    # It's available whenever you called {SmartInit#smart_init smart_init} before.
    # You can call {SmartInit#smart_init smart_init} from any location in your project directory.
    # * main_dir = File.join(Drumherum.directory_main)
    # * lib_dir = File.join(Drumherum.directory_main, 'lib')
    # * test_dir = File.join(Drumherum.directory_main, 'test')
    # @return [Array]
    #
    def directory_main
      @directory_main || []
    end      
    
    
    # @return [void] indicates setup complete. All require-statements are done.
    def loaded!
      @loaded = true
    end
    
    
    # @return [true, false] setup complete? All require-statements done?       
    def loaded?
      @loaded 
    end    
    
    # @return [String] URI to github (source)     
    def url_source
      "https://github.com/#{Drumherum.github_username}/#{Drumherum.project_name}"
    end   

    # @return [String] URI to github (documentation)       
    def url_docs
      "http://#{Drumherum.github_username}.github.com/#{Drumherum.project_name}/frames.html"
    end     
       
    
  end # moduldefinitionen   
  
end


# {SmartInit#smart_init smart_init} finds the directory named 'lib' in your project and adds
# * the (main) directory above
# * the lib-directory itself 
# to Rubys $LOAD_PATH. So your require statements load the actual version from your (local) project directory, not the (public) gem version.
#
# Also, {SmartInit#smart_init smart_init} sets some {Drumherum release infos} for Hoe. 
#
# Usage (wherever you are in the directory hierarchy of your project):
#  if $0 == __FILE__ 
#    require 'drumherum'
#    smart_init 
#  end
#  require 'my-gem-project'   # actual local version, not the gem version
#
module SmartInit 

  # @!group Included in Object

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

# @private
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










