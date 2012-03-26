ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :authentication       => "plain",
  :enable_starttls_auto => true,
  :user_name            => CONFIG[:smtp_username],
  :password             => CONFIG[:smtp_password]
}

ActionMailer::Base.default_url_options[:host] = CONFIG[:host]
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
