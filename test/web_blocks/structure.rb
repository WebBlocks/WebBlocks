require 'test/unit'
require 'web_blocks/structure'

class TestStructure < Test::Unit::TestCase

  def test_namespace

    assert_nothing_raised("Structure module defined"){ WebBlocks::Structure }

  end

  def test_structures_classes

    ['Block','FontFile','Framework','ImgFile','JsFile','RawFile','ScssFile'].each do |type|
      klass = nil
      assert_nothing_raised("#{type} class defined"){ klass = eval "WebBlocks::Structure::#{type}" }
      assert klass.class == Class
    end

  end

  def test_structure_attribute_modules

    ['Dependency','LooseDependency'].each do |type|
      mod = nil
      assert_nothing_raised("Attribute::#{type} module defined"){ mod = eval "WebBlocks::Structure::Attribute::#{type}" }
      assert mod.class == Module
    end

  end

  def test_structure_tree_classes

    ['LeafNode','Node'].each do |type|
      klass = nil
      assert_nothing_raised("Tree::#{type} class defined"){ klass = eval "WebBlocks::Structure::Tree::#{type}" }
      assert klass.class == Class
    end

  end

end