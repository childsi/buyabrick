module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home page/i
      root_path
    when /the bricks page/i
      bricks_path
    when /the bricks rss page/i
      bricks_path(:format => 'rss')
    when /the naughty bricks page/i
      naughties_bricks_path
    when /the new (.+) brick page/i
      brick_new_with_value_path($1)
    when /the "(.+)" brick page/i
      brick_path($1)
    when /the edit "(.+)" brick page/i
      edit_brick_path($1)
    when /the "(.+)" brick thanks page/i
      thanks_brick_path($1)
    when /the "(.+)" payment notification return page for donationId "(\d+)"/i
      return_payment_notification_path($1) + "?donationId=#{$2}"
    when /the "(.+)" payment notification return page/i
      return_payment_notification_path($1)
    when /the "(.+)" payment notification failed page/i
      failed_payment_notification_path($1)
    when /the wall (.+) feed/i
      wall_path(:format => $1)
      
    when /the reports page/
      reports_path
    when /the "(.+)" report page/
      report_path($1)
    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
