class Test

  @@test_context = nil

  class << self
    attr_accessor :test_context
  end

  def self.run
    tests = public_instance_methods.grep( /_test/ )
    tests.each do | t |
      self.test_context = self.new
      self.test_context.before
      self.test_context.send( t )
      puts "#{t} passed"
    end
  end

  def let(symb)
    attr     = ('@'+symb.to_s).to_sym
    attr_set = (symb.to_s+'=').to_sym

    self.class.test_context.instance_variable_set attr, yield

    self.define_singleton_method(symb) do
      eval attr.to_s
    end

    self.define_singleton_method(attr_set) do |val|
      attr = val
    end
  end

  def assert test, msg = 'no reason offered'
    unless test then
      bt = caller.drop_while { |s| s =~ /#{__FILE__}/}
      source        = bt.first
      test_name     = source[ /:in .(.+)'/, 1]
      file_and_line = source[ /\/([^\/]*:\d*):/, 1]
      puts "#{test_name} failed (#{file_and_line}) #{msg}"
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

  def test(name='Untitled')
    yield
  end

end

