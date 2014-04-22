class Message < ActiveRecord::Base
  validates :title, :content, presence: true
  #validates_uniqueness_of :title
  validates_length_of :title, in: 4..64
  validates_length_of :content, in: 12..192

  UA_IOS_LIMIT = 256

  before_validation :check_payload
  after_create :send_ua

  def ua_payload_ios
    @ua_payload_ios ||=
    {
      tags: ['ios'],
      aps: {
        alert: title,
        content: content,
        badge: 1
      }
    }
  end

  def ua_payload_android
    @ua_payload_android ||=
    {
      tags: ['android'],
      android: {
        alert: title,
        extra: {
          content: content
        }
      }
    }
  end

protected

  def check_payload
    if ua_payload_ios.to_json.bytesize > UA_IOS_LIMIT
      errors.add :content, "Payload size is too big"
    end
  end

  def send_ua
    Urbanairship.push ua_payload_ios
    Urbanairship.push ua_payload_android
  end
end
