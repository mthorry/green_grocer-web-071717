require "pry"

def consolidate_cart(cart)
  consolidated = {}

  cart.each do |food|
    food.each do |food_name, food_hash|
# binding.pry
      if consolidated[food_name]
        consolidated[food_name][:count] += 1
      else
        consolidated[food_name] = food_hash
        consolidated[food_name][:count] = 1
      end
    end
  end
consolidated
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|

     if cart.include?(coupon[:item]) == false || cart[coupon[:item]][:count] - coupon[:num] < 0
     elsif cart.include?(coupon[:item]) && cart.include?("#{coupon[:item]} W/COUPON")
         cart[coupon[:item]][:count] = cart[coupon[:item]][:count] - coupon[:num]
         cart["#{coupon[:item]} W/COUPON"][:count] += 1
     else
         cart[coupon[:item]][:count] = cart[coupon[:item]][:count] - coupon[:num]
         cart["#{coupon[:item]} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[coupon[:item]][:clearance], :count => 1}
     end
   end

   cart
end


def apply_clearance(cart)

  cart.each do |food, attribute|
    if attribute[:clearance] == true
      attribute[:price] = (attribute[:price]*0.8).round(2)
    end
  end
  cart

end


def checkout(cart, coupons)
  # binding.pry
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  # binding.pry
  total = 0

  cart.each do |food, info|
    total += info[:price] * info[:count]
  end

  if total >= 100
    total = (total*0.9).round(2)
  end

return total

end
