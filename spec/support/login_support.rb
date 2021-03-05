module LoginSupport
  def login(user, remember_me: '1')
    get login_path
    post login_path, params: { session: { email: user.email, password: user.password, remember_me: remember_me } }
  end

  def log_in_as(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end