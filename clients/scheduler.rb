#!/usr/bin/env ruby

require 'raspeomix'

EM.run {
  client = Raspeomix::Client::Scheduler.new
  client.play_scenario("/home/pi/dev/raspeomix/tests")
}
