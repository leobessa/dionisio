module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    

    when /principal/
      root_path
    when /de login de adminstrador/
      new_admin_session_path
    when /de envio de convites/
      new_invitation_path
    when /de cadastro de participante/
      signup_path
    when /de login/
      new_user_session_path  
    when /^do produto com id "([^\"]*)"$/i
      product_path($1)
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
