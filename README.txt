
= Drumherum

http://bklippstein.github.com/drumherum/

== $LOAD_PATH management
+smart_init+ finds the directory named 'lib' in your project and adds
* the (main) directory above
* the lib-directory itself 
to Rubys $LOAD_PATH. So your require statements load the actual version from your project directory, not the gem version.

Usage (wherever you are in the directory hierarchy of your project):
  if $0 == __FILE__ 
    require 'drumherum'
    smart_init 
  end
  require 'my-gem-project'  

== Rake tasks for deployment
  rake publish               # publish all on github and rubygems, reinstall gem
  rake git_publish           # publish actual version to github  
  rake git_publish_docs      # publish docs to github
  rake rubygems_publish      # release actual version to rubygems

== Unit Tests
You will see a status display for your tests if you use UnitTest instead of Test::Unit::TestCase: 




          


== License
cc-by-sa

Creative Commons Attribution-Share Alike 3.0 Germany

http://creativecommons.org/licenses/by-sa/3.0/de/deed.en


== Homepage
http://bklippstein.github.com/drumherum/


== Author
Björn Klippstein 


== Disclaimer
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
