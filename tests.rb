require './diy_test'

class RunTest
  def a
    @a ||= 1
  end

  def passing_test
    assert_equal 1, a
  end

  def failing_test
    assert_equal 1, 2
  end
end

RunTest.run




