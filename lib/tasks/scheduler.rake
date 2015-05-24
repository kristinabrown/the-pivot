desc "This task is called by the Heroku scheduler add-on"
task :create_orders => :environment do
  puts "Creating orders..."
  Order.create_order
  puts "done."
end
