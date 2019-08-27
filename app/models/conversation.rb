class Conversation
  def self.find_messages(from, to)
    messages = Rails.cache.read(Date.today.to_s + "_messages_#{to}_#{from}").to_a + Rails.cache.read(Date.today.to_s + "_messages_#{from}_#{to}").to_a
    messages = messages.compact.sort_by{|message| DateTime.parse(message[:created_at].to_s)}
  end
end
