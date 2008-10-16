#! /usr/bin/ruby
#
#  rails_boot_strap.rb
#  active_resource
#
#  Created by James Burka on 10/15/08.
#  Copyright (c) 2008 Burkaprojects. All rights reserved.
#
#  populate.rake  is located in RAILS_ROOT/lib/tasks 
#  it requires the gems : populator , faker



RAILS_ENV = "test"
RAILS_APP_DIR = "sample_rails_app"

class RailsBootStrap

  def initialize(pathToRails)
    puts pathToRails
    Dir.chdir(pathToRails)
  end

  def setup()
    
    run_command("rake db:populate RAILS_ENV=#{RAILS_ENV}")

  end
  
  def launch()
  
    #run_command("script/server -e #{RAILS_ENV} &")
  
  end
  
  private 
  
  def run_command(command)
    system(command)
  end

end


rails = RailsBootStrap.new(File.join(File.dirname(__FILE__),RAILS_APP_DIR))
rails.setup
rails.launch


