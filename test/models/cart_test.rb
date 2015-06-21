require 'test_helper'

class CartTest < ActiveSupport::TestCase

  test "the truth" do
    cart = Cart.new
    assert cart.valid?
  end

  test "cart line item should save price" do
    cart = carts(:cart1)
    [:ruby, :one].each do |p|
      product = products(p)
      cart.add_product(product.id).save
      item = cart.line_items.find_by(product_id: product.id)
      assert_equal item.price, product.price, "cart line item did not save price"
    end
  end

  test "cart line item quantity should increment" do
    cart = carts(:cart2)
    product = products(:ruby)
    multiple = 3
    multiple.times { cart.add_product(product.id).save }
    item = cart.line_items.find_by(product_id: product.id)
    assert_equal multiple, item.quantity, "cart line item quantity is incorrect"
  end

  test "cart line item price should equal most-recent price" do
    cart = carts(:cart3)
    product = products(:ruby)
    cart.add_product(product.id).save
    item = cart.line_items.find_by(product_id: product.id)
    assert_equal product.price, item.price, "line item and product prices do not match"
  end

  test "cart should be created and destroyed" do
    cart = Cart.create
    assert cart.valid?, "cant create cart, Cart.create invalid."
    assert cart.destroy, "can't destroy cart"
  end

end
