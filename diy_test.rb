def assert test, msg = 'Failed test'
  unless test then
    bt = caller.drop_while { |s| s =~ /#{__FILE__}/ }
    raise RuntimeError, msg, bt
  end
end

def assert_equal(a, b)
  assert( a == b, "expected #{a} got #{b}")
end

def assert_with_delta(a, b)
  delta = 0.001
  assert( (a - b).abs < delta, "expected #{a} got #{b}" )
end

def test(name='Untitled')
  yield
end

