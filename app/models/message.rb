class Message
  def self.where(attributes)
    if attributes[:to] == 'global'
      cache_key = Date.today.to_s + "_messages_#{to}"
    else
      cache_key = Date.today.to_s + "_messages_#{to}_#{from}"
    end

    Rails.cache.read(cache_key) || []
  end

  def self.create(attributes)
    if attributes[:to] == 'global'
      cache_key = Date.today.to_s + "_messages_#{to}"
    else
      cache_key = Date.today.to_s + "_messages_#{to}_#{from}"
    end

    messages = where(attributes)
    messages << {
      body: attributes[:body],
      from: attributes[:from],
      to: attributes[:to],
      created_at: DateTime.now.to_s
    }

    Rails.cache.write(cache_key, messages)
  end
end
