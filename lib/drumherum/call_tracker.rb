# ruby encoding: utf-8


# http://oreilly.com/catalog/9780596523695/
# Ruby Cookbook, by Lucas Carlson and Leonard Richardson
# Copyright 2006 O'Reilly Media
# @private
class CallTracker 

  # Initialize and start the trace.
  def initialize(show_stack_depth=1)
    @show_stack_depth = show_stack_depth
    @to_trace = Hash.new { |h,k| h[k] = {} }
    start
    at_exit { stop }
  end

  # Register a class/method combination as being interesting. Subsequent calls
  # to the method will be tallied by tally_calls.
  def register(klass, method_symbol)	
    @to_trace[klass][method_symbol] = {}
  end

  # Tells the Ruby interpreter to call tally_calls whenever it's about to
  # do anything interesting.
  def start
    set_trace_func method(:tally_calls).to_proc
  end

  # Stops the profiler, and prints a report of the interesting calls made
  # while it was running.
  def stop(out=$stderr)
    set_trace_func nil
    report(out)
  end

  # If the interpreter is about to call a method we find interesting,
  # increment the count for that method.
  def tally_calls(event, file, line, symbol, binding, klass)
    if @to_trace[klass] and @to_trace[klass][symbol] and 
	(event == 'call' or event =='c-call')
      stack = caller
      stack = stack[1..(@show_stack_depth ? @show_stack_depth : stack.size)]
      @to_trace[klass][symbol][stack] ||= 0
      @to_trace[klass][symbol][stack] += 1
    end    
  end  

  # Prints a report of the lines of code that called interesting
  # methods, sorted so that the the most active lines of code show up
  # first.
  def report(out=$stderr)
    first = true
    @to_trace.each do |klass, symbols|
      symbols.each do |symbol, calls| 
        total = calls.inject(0) { |sum, ct| sum + ct[1] }        
        padding = total.to_s.size
        separator = (klass.is_a? Class) ? '#' : '.'
        plural = (total == 1) ? '' : 's'
        stack_join = "\n" + (' ' * (padding+2))
        first ? first = false : out.puts
        out.puts "#{total} call#{plural} to #{klass}#{separator}#{symbol}"
        (calls.sort_by { |caller, times| -times }).each do |caller, times|
          out.puts " %#{padding}.d #{caller.join(stack_join)}" % times
        end       
      end
    end
  end
end