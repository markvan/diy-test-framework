require './diy_test'

class SampleTests < Test

  def before
    set_attr(:b){2}
  end

  def passing_test
    assert_equal 1, 1
  end

  def failing_test
    self.b = 2222
    assert_equal 1, b
  end
end

SampleTests.run




