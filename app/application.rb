class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      search_term = req.path.split("/items/").last
      search_item = @@items.find { |item| item.name == search_term }
      if (search_item.nil?)
        resp.write "Item not found"
        resp.status = 400
      else
        resp.write search_item.price
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
