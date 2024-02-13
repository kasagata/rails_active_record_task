class ExercisesController < ApplicationController
  def exercise1
    # 【要件】注文されていないすべての料理を返すこと
    #   * left_outer_joinsを使うこと
    @foods = Food.left_outer_joins(:order_foods).where(order_foods: {food_id: nil })
  end

  def exercise2
    # 【要件】注文されていない料理を提供しているすべてのお店を返すこと
    #   * left_outer_joinsを使うこと
    @shops = Shop.left_outer_joins(foods: :order_foods).where(order_foods: {food_id: nil })
    SELECT "shops".* FROM "shops" 
    LEFT OUTER JOIN "foods" 
    ON "foods"."shop_id" = "shops"."id" 
    LEFT OUTER JOIN "order_foods" 
    ON "order_foods"."food_id" = "foods"."id" 
    WHERE "order_foods"."food_id" IS NULL
  end

  no_order_foods = Food.left_outer_joins(:order_foods).where(order_foods: {food_id: nil })
  @shops = Shop.left_outer_joins(:foods).where(foods: no_order_foods).uniq
  SELECT "shops".* FROM "shops" LEFT OUTER JOIN "foods" ON "foods"."shop_id" = "shops"."id" WHERE "shops"."id" IN (SELECT "foods"."shop_id" FROM "foods" LEFT OUTER JOIN "order_foods" ON "order_foods"."food_id" = "foods"."id" WHERE "order_foods"."food_id" IS NULL)

  def exercise3 
    # 【要件】配達先の一番多い住所を返すこと
    #   * joinsを使うこと
    #   * 取得したAddressのインスタンスにorders_countと呼びかけると注文の数を返すこと
    most_order = Address.joins(:orders).group(:id).order('count_all DESC').count.first
    @address = Address.joins(:orders).where(id: most_order[0])

  end

  def exercise4 
    # 【要件】一番お金を使っている顧客を返すこと
    #   * joinsを使うこと
    #   * 取得したCustomerのインスタンスにfoods_price_sumと呼びかけると合計金額を返すこと
    @customer = Customer.joins(orders: :foods).group(:name).order('sum_price DESC').sum(:price).first
    
  end
end
