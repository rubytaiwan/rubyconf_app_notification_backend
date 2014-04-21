class Message < ActiveRecord::Base
  validates :title, :content, presence: true
  validates_uniqueness_of :title
  validates_length_of :title, in: 4..64
  validates_length_of :content, in: 12..192


  after_create :send_ua

protected

  def to_ua_ios
    {
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
