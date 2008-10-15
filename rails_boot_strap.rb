#! /usr/bin/ruby
#
#  boot_strap.rb
#  active_resource
#
#  Created by James Burka on 10/15/08.
#  Copyright (c) 2008 Burkaprojects. All rights reserved.
#

RAILS_ENV = "test"
RAILS_APP_DIR = "sample_rails_app"

class RailsBootStrap

  def initialize(pathToRails)
    puts pathToRails
    Dir.chdir(pathToRails)
  end

  def setup()
    
    run_command("rake db:drop RAILS_ENV=#{RAILS_ENV}")
    run_command("rake db:create RAILS_ENV=#{RAILS_ENV}")
    run_command("rake db:migrate RAILS_ENV=#{RAILS_ENV}")
    run_command("rake db:fixtures:load RAILS_ENV=#{RAILS_ENV}")

  end
  
  def launch()
  
    run_command("script/server -e #{RAILS_ENV} &")
  
  end
  
  private 
  
  def run_command(command)
    system(command)
  end

end


rails = RailsBootStrap.new(File.join(File.dirname(__FILE__),RAILS_APP_DIR))
rails.setup
rails.launch


