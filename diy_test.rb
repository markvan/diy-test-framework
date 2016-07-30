class Test

  def self.run
    tests = public_instance_methods.grep( /_test/ )
    tests.each do | t |
      test_context = self.new
      test_context.before unless public_instance_methods.grep( /^before$/ ).empty?
      test_context.send( t )
      test_context.print_success(t)
    end
  end

  def let(symb)
    symb_inst_var = ('@'+symb.to_s).to_sym
    instance_variable_set symb_inst_var, yield
    define_singleton_method(symb) do
      instance_variable_get symb_inst_var
    end
    define_singleton_method(symb.to_s+'=') do |val|
      instance_variable_set symb_inst_var, val
    end
  end

  def assert(test, msg = 'no reason offered')
    unless test then
      bt = caller.drop_while { |s| s =~ /#{__FILE__}/}
      print_failure(bt, msg)
      raise RuntimeError, msg, bt
    end
  end

  def assert_equal(a, b)
    assert(a == b, "expected #{a} got #{b}")
  end

  def assert_with_delta(a, b)
    delta = 0.001
    assert((a - b).abs < delta, "expected #{a} got #{b}")
  end

  def print_success(t)
    puts "#{t} passed"
  end

  def print_failure(bt, msg)
    source        = bt.first
    test_name     = source[ /:in `(.+)'/, 1]
    file_and_line = source[ /\/([^\/]*:\d*):/, 1]
    puts "#{test_name} failed (#{file_and_line}) #{msg}"
  end

end

