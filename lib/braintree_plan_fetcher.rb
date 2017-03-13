class BraintreePlanFetcher
  def self.store_locally
    # ver1
    # Braintree::Plan.all
    Braintree::Plan.all.each do |plan|
      Plan.create({
        name: plan.name,
        price: plan.price,
        braintree_id: plan.id,
      })
    end
  end
end
