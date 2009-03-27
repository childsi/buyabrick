def path_to(page_name)
  case page_name
  
  when /the homepage/i
    root_path
  when /the bricks page/i
    bricks_path
  when /the naughty bricks page/i
    naughties_bricks_path
  when /the new (.+) brick page/i
    brick_new_with_value_path($1)
  
  # Add more page name => path mappings here
  
  else
    raise "Can't find mapping from \"#{page_name}\" to a path."
  end
end