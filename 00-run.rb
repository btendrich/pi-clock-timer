#!/usr/bin/env ruby
require 'pp'
require 'logger'

$logger = Logger.new(STDOUT)

CONFIGS = {
  'B8:27:EB:03:6D:B9' => :clock,
  'B8:27:EB:F0:D0:2D' => :timer,
}

$logger.info "Starting up..."

hwaddr = `ifconfig eth0 | grep ether | awk '{print $2}'`.chomp.upcase

$logger.info "Hardware address is '#{hwaddr}'"
option = CONFIGS.fetch(hwaddr, :default)

case option
when :clock
  $logger.info "Running option 'clock'"
  loop do
    `cp /home/pi/pi-clock-timer/clock_720 /tmp/running`
    `/tmp/running`
    sleep 1
  end
when :timer
  $logger.info "Running option 'timer'"
  loop do
    `cp /home/pi/pi-clock-timer/countup_timer_720 /tmp/running`
    `/tmp/running`
    sleep 1
  end
else
  $logger.info "Running default option"
  loop do
    `cp /home/pi/pi-clock-timer/pi-graphical-status /tmp/running`
    `/tmp/running`
    sleep 1
  end
end

