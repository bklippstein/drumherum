# ruby encoding: utf-8


class String

  # Easy development of regular expressions.
  # @return [String] result of the match  
  # @param [Regexp] regular_expression to match with +self+
  # 
  def show_regexp(regular_expression)
      if self =~ regular_expression
          "#{$`}<<#{$&}>>#{$'}"
      else
          "no match"
      end # if
  end  

end

if defined? TransparentNil
  # @private
  class NilClass
    def show_regexp(*a);                          nil;            end 
  end
end


