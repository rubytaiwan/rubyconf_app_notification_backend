AppSetting.urbanairship.each do |k,v|
  Urbanairship.send(:"#{k}=", v)
end
Urbanairship.logger = Rails.logger
