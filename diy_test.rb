class RunTest

  def self.run
    meths = public_instance_methods.grep( /_test$/ )
    meths.each{|meth| self.new.send(meth); puts "#{meth} passed"}
  end

  def assert test, msg = 'no reason offered'
    unless test then
      bt = caller.drop_while { |s| s =~ /#{__FILE__}/ }
      source        = bt.first
      test_name     = source.scan( /:in .(.+)'/)[0][0]
      file_and_line = source.scan( /\/([^\/]*:\d*):/ )[0][0]
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

  def let (symb)
  end


end

