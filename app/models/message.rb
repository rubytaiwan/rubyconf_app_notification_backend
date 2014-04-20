class Message < ActiveRecord::Base
  validates :title, :content, presence: true
  validates_uniqueness_of :title

  after_create :send_ua

protected

  def to_ua_ios
    {
      aliases: ['ios'],
      aps: {
        alert: title,
        content: content,
        badge: 1
      }
    }
  end

  def send_ua
    Urbanairship.push to_ua_ios
  end
end
