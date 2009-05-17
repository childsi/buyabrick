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
    when /the naughty bricks page/i
      naughties_bricks_path
    when /the new (.+) brick page/i
      brick_new_with_value_path($1)
    when /the wall (.+) feed/i
      wall_path(:format => $1)
    
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
