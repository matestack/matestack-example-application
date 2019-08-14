class Base
  def self.find(id)
    Rails.cache.read("#{Date.today.to_s}_#{self.to_s.downcase}_#{id}")
  end

  def save
    self.id = Cuid.generate if self.id.nil?
    Rails.cache.write("#{Date.today.to_s}_#{self.class.to_s.downcase}_#{self.id}", self)
  end

  def self.create(attributes)
    element = new(attributes)
    element.save
    element 
  end

  def update(attributes)
    self.description = attributes.description
    Rails.cache.write("#{Date.today.to_s}_#{self.class.to_s.downcase}_#{self.id}", self)
  end

  def destroy
    Rails.cache.delete("#{Date.today.to_s}_#{self.class.to_s.downcase}_#{self.id}")
  end
end
