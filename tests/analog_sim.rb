#!/usr/bin/env ruby
#
require 'raspeomix'
require 'faye'
require 'eventmachine'
require 'json'
EM.run {
  @hostname=`hostname`.chomp
  @client=Faye::Client.new("http://localhost:#{ENV['RASP_PORT']}/faye")

  message = { :type => "client_update", :properties => {
                :client => "/sensors/analog/test",
                :converted_value => 210
              }
            }
  message2 = { :type => "client_update", :properties => {
                :client => "/sensors/analog/test",
                :converted_value => 100
              }
            }

   EM.add_periodic_timer(1){
     @client.publish("/#{@hostname}/sensors/analog/test", message)
     Raspeomix.logger.debug("sending message : #{message}")
   }
   EM.add_periodic_timer(10){
     @client.publish("/#{@hostname}/sensors/analog/test", message2)
     Raspeomix.logger.debug("sending message : #{message2}")
   }
#   EM.add_timer(10){
#     @client.publish("/#{@hostname}/sound", {:state=>:on, :level=>0})
#   }
#   EM.add_timer(15){
#     @client.publish("/#{@hostname}/sound", {:state=>:on, :level=>50})
#   }
#   EM.add_timer(20){
#     @client.publish("/#{@hostname}/scenario", {:command=>"pause"})
#   }
#   EM.add_timer(25){
#     @client.publish("/#{@hostname}/scenario", {:command=>"play"})
#   }
}
