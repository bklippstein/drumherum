# ruby encoding: utf-8
require 'test/unit'


class UnitTest < Test::Unit::TestCase # :nodoc:

  # Meldet den aktuell durchlaufenden Test
  def test0 #:nodoc:
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

class Test030Blatest < UnitTest # :nodoc:

  def test_bla
    # 1 / 0 
    assert false
  end

end





end

