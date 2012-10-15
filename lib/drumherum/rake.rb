# ruby encoding: utf-8

#== *Rake* 
#Beispiele siehe Rakefile.rb
#* Methode remove_task, um Tasks überschreiben zu können


#  ----------------------------------------------------------------------------------------------
#  Rake initialisieren
#  

require 'rake'
#require 'rake/testtask'


  

#   ----------------------------------------------------------------------------------------------
#   Ergänzung: Alte Tasks entfernen
#   sonst kann man sie nämlich nicht überschreiben!
#   Beispiel: remove_task 'test:plugins'     
#   Quelle: http://matthewbass.com/2007/03/07/overriding-existing-rake-tasks/
#   dies hier stimmt nicht: http://www.dcmanges.com/blog/modifying-rake-tasks
   
Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

def remove_task(task_name)
  Rake.application.remove_task(task_name)
end




# -------------------------------------------------------------------------------------------------------
# publish
#

  # Task :publish
  #
  desc 'publish all on github and rubygems, reinstall gem'
  task :publish => [ :utf8, :redocs, :rubygems_publish, :gem_uninstall, :git_publish, :git_publish_docs, :sleep_15, :utf8, :gem_install] do
    puts 'done.'
  end  



# -------------------------------------------------------------------------------------------------------
# git
#


  # git_publish
  #
  desc 'publish actual version to github'
  task :git_publish => [ :git_add, :git_commit, :git_push ] do
    puts; puts; puts; puts   
    if Hoe::WINDOZE
      sh "start https://github.com/#{Drumherum.github_username}/#{Drumherum.project_name} "
    else
      puts "done. Visit https://github.com/#{Drumherum.github_username}/#{Drumherum.project_name} "
    end
  end  
  
  
    
  # git_status
  #
  desc 'git status'
  task :git_status do
    if Hoe::WINDOZE
      sh "git status "
      sh 'chcp 65001 > NUL '
    else
      sh "sudo git status "
    end  
  end        
    
  
  
  # git_add
  #
  desc 'git_add -A'
  task :git_add do
    if Hoe::WINDOZE
      sh "git add -A "
      sh 'chcp 65001 > NUL '
    else
      sh "sudo git add -A "
    end    
  end    
    
  
  
  # git_commit
  #
  desc 'git commit -m'
  task :git_commit do
    if Hoe::WINDOZE
      sh 'git commit -m "---" '
      sh 'chcp 65001 > NUL '
    else
      sh 'sudo git commit -m "---" '
    end     
  end  


  # git push origin master
  #
  desc 'git_push'
  task :git_push do
    if Hoe::WINDOZE
      sh 'git push origin master '
      sh 'chcp 65001 > NUL '
    else
      sh 'sudo git push origin master '
    end     
  end  


  
  # git_publish_docs
  #
  desc 'publish docs to github'
  task :git_publish_docs do
    puts; puts; puts; puts     
  
    # Repository erstellen, wenn nötig
    Dir.chdir '/tmp' do
      sh "#{'sudo ' unless Hoe::WINDOZE }git clone https://github.com/#{Drumherum.github_username}/#{Drumherum.project_name} " do |ok,res|
        if ok
          Dir.chdir "/tmp/#{Drumherum.project_name}" do
            if Hoe::WINDOZE
              sh 'git checkout --orphan gh-pages '
              sh 'chcp 65001 > NUL '
            else
              sh 'sudo git checkout --orphan gh-pages '
            end            
          end # do chdir      
        else # not ok      
          sh 'chcp 65001 > NUL '   if Hoe::WINDOZE
        end
      end # do sh
    end # do chdir
    
    # alles löschen
    Dir.chdir "/tmp/#{Drumherum.project_name}" do 
      if Hoe::WINDOZE
        sh 'git rm -rf --ignore-unmatch . '
        sh 'chcp 65001 > NUL '
      else
        sh 'sudo git rm -rf --ignore-unmatch . '
      end      
    end    
    
    # doc rüberkopieren 
    Dir.chdir 'doc' do
      if Hoe::WINDOZE
        sh "xcopy /E *.* \\tmp\\#{Drumherum.project_name} "
      else
        sh "sudo cp . /tmp/#{Drumherum.project_name} "
      end      
    end      
    
    # publish   
    Dir.chdir "/tmp/#{Drumherum.project_name}" do
      if Hoe::WINDOZE
        sh 'git add -A '    
        sh 'git commit -m "---" --allow-empty'
        sh 'git push origin +gh-pages '  # C:\Users\Klippstein\_netrc enthält die Login-Daten      
        sh "start http://#{Drumherum.github_username}.github.com/#{Drumherum.project_name} "
        sh 'chcp 65001 > NUL '        
      else
        sh 'sudo git add -A '    
        sh 'sudo git commit -m "---" --allow-empty'
        sh 'sudo git push origin +gh-pages '  # .netrc enthält die Login-Daten           
        puts "done. Visit http://#{Drumherum.github_username}.github.com/#{Drumherum.project_name} "
      end # if   
    
    end # do chdir   
    
        
  end # do task
    
    

  
# -------------------------------------------------------------------------------------------------------
# rubygems
#  

  
  # Task :rubygems_publish
  #
  desc 'release actual version to rubygems'
  task :rubygems_publish  do
    puts; puts; puts; puts  
    ENV["VERSION"] = Drumherum.project_version
    Rake::Task[:release].invoke

  end  


  
  # Task :gem_uninstall
  #
  desc 'uninstall old gem'
  task :gem_uninstall do
    puts; puts; puts; puts   
    sh "#{'sudo ' unless Hoe::WINDOZE }gem uninstall #{Drumherum.project_name} --a --ignore-dependencies "
  end  
  

  
  # Task :gem_install
  #
  desc 'install gem from rubygems'
  task :gem_install do
    puts; puts; puts; puts        
    sh "#{'sudo ' unless Hoe::WINDOZE }gem install #{Drumherum.project_name} "
  end    
  





# -------------------------------------------------------------------------------------------------------
# Div
#

# Task :utf8
#
desc 'Set Codepage to 65001'
task :utf8 do

  sh 'chcp 65001 > NUL '  if Hoe::WINDOZE

end


# Task :version
#
desc 'VERSION of the current project'
task :version do

    puts "\n#{Drumherum.project_name} (#{Drumherum.project_version})\n\n"

end



# Task :sleep_5
#
desc 'Sleep 5 seconds'
task :sleep_5 do
  puts 
  puts 
  puts 
  if Hoe::WINDOZE
    sh "wait 5"
  else
    sh "sleep 5"
  end

end


# Task :sleep_15
#
desc 'Sleep 15 seconds'
task :sleep_15 do
  puts 
  puts 
  puts 
  if Hoe::WINDOZE
    sh "wait 15"
  else
    sh "sleep 15"
  end

end


 
  
    # namespace :manifest do
    # desc 'Recreate Manifest.txt to include ALL files'
    # task :refresh do
      # `rake check_manifest | patch -p0 > Manifest.txt`
    # end
  # end
  
