def assert test, msg = 'Failed test'
  unless test then
    bt = caller.drop_while { |s| s =~ /#{__FILE__}/ }
    raise RuntimeError, msg, bt
  end
end

def assert_equal(a, b)
  assert a == b
end

