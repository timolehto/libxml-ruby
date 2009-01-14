require 'xml'
require 'test/unit'

class AttrNodeTest < Test::Unit::TestCase
  def setup
    file = File.join(File.dirname(__FILE__), 'model/itunes.xml')
    xp = XML::Parser.file(file)
    @doc = xp.parse
  end
  
  def teardown
    @doc = nil
  end

  def test_attributes
    # Get a property node without a access attribute
    elem = @doc.find_first('/dictionary/suite/class/property[@code="pEnc"]')

    # access should not be in the attributes hash
    assert_equal(4, elem.attributes.length)
    assert_nil(elem['access'])
  end

  def test_attr_decl
    # Get a property node without a access attribute
    elem = @doc.find_first('/dictionary/suite/class/property[@code="pEnc"]')

    # Get the attr_decl
    attr_decl = elem.attributes.get_attribute('access')
    assert_not_nil(attr_decl)
    assert_equal(XML::Node::ATTRIBUTE_DECL, attr_decl.node_type)
    assert_equal('attribute declaration', attr_decl.node_type_name)

    # Get its value
    assert_equal('rw', attr_decl.value)
  end

  def test_type
    # Get a property node without a access attribute
    elem = @doc.find_first('/dictionary/suite/class/property[@code="pEnc"]')
    attr_decl = elem.attributes.get_attribute('access')

    assert_not_nil(attr_decl)
    assert_equal(XML::Node::ATTRIBUTE_DECL, attr_decl.node_type)
    assert_equal('attribute declaration', attr_decl.node_type_name)
  end
  
  def test_name
    elem = @doc.find_first('/dictionary/suite/class/property[@code="pEnc"]')
    attr_decl = elem.attributes.get_attribute('access')

    assert_equal('access', attr_decl.name)
  end

  def test_value
    elem = @doc.find_first('/dictionary/suite/class/property[@code="pEnc"]')
    attr_decl = elem.attributes.get_attribute('access')

    assert_equal('rw', attr_decl.value)
  end

#  def test_set_value
#    attribute = city_member.attributes.get_attribute('name')
#    attribute.value = 'London'
#    assert_equal('London', attribute.value)
#
#    attribute = city_member.attributes.get_attribute('href')
#    attribute.value = 'http://i.have.changed'
#    assert_equal('http://i.have.changed', attribute.value)
#  end
#
#  def test_set_nil
#    attribute = city_member.attributes.get_attribute('name')
#    assert_raise(TypeError) do
#      attribute.value = nil
#    end
#  end
#
#  def test_create
#    attributes = city_member.attributes
#    assert_equal(5, attributes.length)
#
#    attr = XML::Attr.new(city_member, 'size', '50,000')
#    assert_instance_of(XML::Attr, attr)
#
#    attributes = city_member.attributes
#    assert_equal(6, attributes.length)
#
#    assert_equal(attributes['size'], '50,000')
#  end
#
#  def test_create_on_node
#    attributes = city_member.attributes
#    assert_equal(5, attributes.length)
#
#    attributes['country'] = 'England'
#
#    attributes = city_member.attributes
#    assert_equal(6, attributes.length)
#
#    assert_equal(attributes['country'], 'England')
#  end
#
#  def test_create_ns
#    assert_equal(5, city_member.attributes.length)
#
#    ns = XML::NS.new(city_member, 'my_namepace', 'http://www.mynamespace.com')
#    attr = XML::Attr.new(city_member, 'rating', 'rocks', ns)
#    assert_instance_of(XML::Attr, attr)
#    assert_equal('rating', attr.name)
#    assert_equal('rocks', attr.value)
#
#    attributes = city_member.attributes
#    assert_equal(6, attributes.length)
#
#    assert_equal('rocks', city_member['rating'])
#  end
#
#  def test_remove
#    attributes = city_member.attributes
#    assert_equal(5, attributes.length)
#
#    attribute = attributes.get_attribute('name')
#    assert_not_nil(attribute.parent)
#    assert(attribute.parent?)
#
#    attribute.remove!
#    assert_equal(4, attributes.length)
#    assert_nil(attribute.parent)
#    assert(!attribute.parent?)
#  end
#
#  def test_first
#    attribute = city_member.attributes.first
#    assert_instance_of(XML::Attr, attribute)
#    assert_equal('name', attribute.name)
#    assert_equal('Cambridge', attribute.value)
#
#    attribute = attribute.next
#    assert_instance_of(XML::Attr, attribute)
#    assert_equal('type', attribute.name)
#    assert_equal('simple', attribute.value)
#
#    attribute = attribute.next
#    assert_instance_of(XML::Attr, attribute)
#    assert_equal('title', attribute.name)
#    assert_equal('Trinity Lane', attribute.value)
#
#    attribute = attribute.next
#    assert_instance_of(XML::Attr, attribute)
#    assert_equal('href', attribute.name)
#    assert_equal('http://www.foo.net/cgi-bin/wfs?FeatureID=C10239', attribute.value)
#
#    attribute = attribute.next
#    assert_instance_of(XML::Attr, attribute)
#    assert_equal('remoteSchema', attribute.name)
#    assert_equal("city.xsd#xpointer(//complexType[@name='RoadType'])", attribute.value)
#
#    attribute = attribute.next
#    assert_nil(attribute)
#  end
#
#  def test_no_attributes
#    element = @doc.find('/city:CityModel/city:type').first
#
#    assert_not_nil(element.attributes)
#    assert_equal(0, element.attributes.length)
#  end
end