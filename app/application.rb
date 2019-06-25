require 'pry'
class Application
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            #accept /item/item_name
            #return price of item
            item_name = req.path.split("/items/").last
            item = Item.all.find{|i| i.name == item_name}
            if Item.all.include?(item)
                resp.write item.price
            elsif item == nil
                resp.write "Item not found"
                resp.status = 400
            end
        else
            #user requests item not available
            #return 400 error
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end