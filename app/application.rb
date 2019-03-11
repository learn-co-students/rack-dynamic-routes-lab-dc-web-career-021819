require 'pry'
class Application

  @@items = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)
    # binding.pry
    if req.path.match( /items/)
      # binding.pry
      search_term = req.path.split("/items/").last
      item = @@items.find {|item| item.name == search_term}
      if item
        resp.write item.price
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
