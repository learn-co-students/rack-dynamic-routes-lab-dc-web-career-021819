class Application

  #@@items = [Item.new("Chips", "1.00"), Item.new("Candy", "0.50")]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      puts item_name + @@items.to_s
      if @@items.find{ |item| item.name == item_name }
        price = @@items.find{
           |item| item.name == item_name
         }.price
         resp.write price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

end
