# ruby encoding: utf-8
require 'test/unit'

# You will see a status display for your tests if you use {UnitTest} instead of Test::Unit::TestCase: 
#
class UnitTest < Test::Unit::TestCase 

  # looks like a test, but just prints status information
  def test0 
    name = self.class.to_s.gsub(/^.*::/, '')
    name.gsub!(/^Test/, '')
    name.gsub!(/^[0-9]+/, '')
    if name != 'UnitTest'  
      print "\n #{name} "
    else
     puts
     puts
    end
  end  
  

end




# ---------------------------------------------------------
# Ausprobieren
#
if $0 == __FILE__ 

# @private
class Test030Blatest < UnitTest # :nodoc:

  def test_bla
    # 1 / 0 
    assert false
  end

end





end

