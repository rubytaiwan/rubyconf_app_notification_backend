class AppSetting < Settingslogic
  source "#{Rails.root}/config/app_setting.yml"
  namespace Rails.env
end
