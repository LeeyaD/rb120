# Alan created the following code to keep track of items for a shopping cart application he's writing:
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end
# Alyssa looked at the code and spotted a mistake. "This will fail when update_quantity is called", she says.

# Can you spot the mistake and how to address it?
# A: Ln. 12 @quantity won't be updated approrpiately b/c Ruby will read it as a local variable being initialized
# !!!! Didn't realize there's only an 'attr_reader' for quantity so we'd also need to change it to an 'attr_accessor'!
# To fix it we need to prefix quantity w/ 'self' so Ruby knows it's a setter method. We can also prefix it with @ but we don't want to reference out instance variable directly.