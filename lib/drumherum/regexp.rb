# ruby encoding: utf-8


class String

  # ---------------------------------------------------------------------------------------------------------------------------------
  # :section: Operation
  #  

  # Zeigt das Ergebnis eines Matches mit einer Regular Expression. Erleichtert das Entwickeln regulärer Ausdrücke.
  # 
  def show_regexp(re)
      if self =~ re
          "#{$`}<<#{$&}>>#{$'}"
      else
          "no match"
      end # if
  end  

end

if defined? TransparentNil
  class NilClass
    def show_regexp(*a);                          nil;            end 
  end
end


