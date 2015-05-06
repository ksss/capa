require "minitest/autorun"
require_relative '../lib/capa'

class TestCapa < Minitest::Test
  def test_embed_array_new_capa
    assert_equal 3, [].capa
    assert_equal 3, [1].capa
    assert_equal 3, [1,2].capa
    assert_equal 3, [1,2,3].capa
  end

  def test_normal_array_new_capa
    assert_equal 31, Array.new(31).capa
  end

  def test_pushed_array_capa
    a = []
    a.push(1,2,3,4,5,6,7)
    assert_equal 23, a.capa
    a.pop
    assert_equal 14, a.capa
    a.pop(5)
    assert_equal 14, a.capa, "shared array"
  end

  def test_DEFAULT_SIZE
    assert_equal 16, Array::DEFAULT_SIZE
  end

  def test_s_capa
    a = Array.capa(31)
    assert_equal 31, a.capa
    assert_equal [], a

    a.push 1, 2, 3
    assert_equal 31, a.capa
    assert_equal [1, 2, 3], a
  end
end
