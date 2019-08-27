class TaskList < Base
  attr_accessor :id, :description, :tasks

  @@all = []

  def initialize(attributes)
    @id = nil
    @description = attributes[:description]
    @tasks = []
  end

  def reload
    self.tasks = TaskList.find(self.id).tasks
    self
  end

  def self.all
    @@all
  end

  def save
    super
    @@all << self if @@all.select{|task| task.id == self.id}.none?
  end
end
