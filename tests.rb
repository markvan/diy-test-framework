require './diy_test'

class SampleTests < Test

  def before
    let(:b){2}
  end

  def passing_test_1
    assert_equal 1, 1
  end

  def passing_test_2
    assert_equal 2, b
  end

  def failing_test
    self.b = 2222
    assert_equal 2, b
  end
end

SampleTests.run




