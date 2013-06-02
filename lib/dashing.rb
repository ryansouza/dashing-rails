require 'rufus-scheduler'

module Dashing
  def self.app_dashing_path
    "app/dashboard"
  end

  def self.histories
    @histories ||= {}
  end

  def self.scheduler
    @scheudler ||= ::Rufus::Scheduler.start_new
  end

  def self.send_event(id, data)
    histories[id] = data.merge id: id, updatedAt: Time.now.utc.to_i
  end
end

require 'dashing/engine'
