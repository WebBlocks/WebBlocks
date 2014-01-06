require 'test/unit'
require 'WebBlocks/support/class/extend_method'

class TestSupportClassExtendMethod < Test::Unit::TestCase

  class Base
    attr_reader :val
    attr_accessor :attr
    def initialize val = nil
      @val = val
      @attr = nil
    end
    def set_val val
      @val = val
    end
  end

  class Extended < Base
    class << self
      include ::WebBlocks::Support::Class::ExtendMethod
    end
    extend_method :initialize do |value = nil|
      previous value ? "initialize:#{value}" : nil
    end
    extend_method :set_val do |value|
      previous "set:#{value}"
    end
    extend_method :attr= do |val|
      previous "attr:#{val}"
    end
  end

  def test_extend_method
    val = 'test'
    base = Base.new
    assert base.val == nil
    base.set_val val
    assert base.val == val
    extended = Extended.new
    assert extended.val == nil
    extended.set_val val
    assert extended.val == "set:#{val}"
  end

  def test_extend_method_initialize
    val = 'test'
    base = Base.new val
    assert base.val == val
    extended = Extended.new val
    assert extended.val == "initialize:#{val}"
  end

  def test_extend_method_attr_accessor
    val = 'test'
    base = Base.new
    assert base.attr == nil
    base.attr = val
    assert base.attr == val
    extended = Extended.new
    assert extended.attr == nil
    extended.attr = val
    assert extended.attr == "attr:#{val}"
  end

end