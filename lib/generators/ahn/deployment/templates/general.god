God::Contacts::Email.defaults do |d|
  d.from_email      = "status@mydomain.com"
  d.from_name       = "<%= project_name.titleize %> Status Monitor"
  d.delivery_method = :sendmail
end

God.contact(:email) do |c|
  c.name = "me"
  c.to_email = "me@mydomain.com"
  c.group = "support"
end

# load in all god configs
God.load File.join(File.dirname(__FILE__), 'god', '*.god')
