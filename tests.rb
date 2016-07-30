require './diy_test'

$count = 0

class SampleTests < Test

  def before
    let(:count) { $count += 1 }
    let(:a){2}
  end

  def setup_once_per_test_test
    assert_equal 1, count
    assert_equal 1, count
  end

  def not_cached_across_tests_test
    assert_equal count, 2
  end

  def passing_test_1
    assert_equal 1, 1
  end

  def passing_test_2
    assert_equal 2, a
  end

  def failing_test
    self.a = 2222
    assert_equal 2, a
  end
end

SampleTests.run




