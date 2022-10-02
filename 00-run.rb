#!/usr/bin/env ruby
require 'pp'
require 'logger'

$logger = Logger.new(STDOUT)

CONFIGS = {
  'B8:27:EB:03:6D:B9' => :clock, # ath clock
  'B8:27:EB:F0:D0:2D' => :timer, # ath timer
  'B8:27:EB:B7:79:D1' => :dgh_clock, # dgh clock
  'B8:27:EB:18:4F:EF' => :timer, # dgh timer
  'B8:27:EB:D6:32:FA' => :dgh_clock,
  'B8:27:EB:E9:95:B8' => :timer,
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
when :dgh_clock
  $logger.info "Running option 'clock'"
  loop do
    `cp /home/pi/pi-clock-timer/dgh-clock /tmp/running`
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

