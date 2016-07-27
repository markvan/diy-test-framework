require './diy_test'


test 'first assert' do
  assert_equal [1,2], [1,2.00001]
end

main

