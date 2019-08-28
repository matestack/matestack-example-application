class Message
  def self.where(attributes)
    cache_key = generate_cache_key(attributes[:to], attributes[:from])
    Rails.cache.read(cache_key) || []
  end

  def self.create(attributes)
    cache_key = generate_cache_key(attributes[:to], attributes[:from])
    messages = where(attributes)
    messages << {
      body: attributes[:body],
      from: attributes[:from],
      to: attributes[:to],
      created_at: DateTime.now.to_s
    }

    Rails.cache.write(cache_key, messages)
  end

  private

    def self.generate_cache_key(to, from)
      if to == 'global'
        cache_key = Date.today.to_s + "_messages_#{to}"
      else
        cache_key = Date.today.to_s + "_messages_#{to}_#{from}"
      end
    end
end
