class Order < ApplicationRecord
    scope :high_cost, -> { where(cost: 1_000..) }
    scope :vip_failed, -> { failed.high_cost }
    scope :created_before, -> (time) { where('created_at < ?', time)}
    # scope :created, -> {where(status == 'created'), Order(Cost: :desc)} # (cost: :desc)  Исправить в сортировки
    
    validates :name, presence: true
    # validates :name, length: { minimum: 10 }
    
    # #validates :cpu, :ram, :hdd_type, :hdd_capacity, presence: true
    # before_validation { |el| el = OptionService.new() }
    # after_validation :do_something_on_update_or_create, on: [:update, :create]  

    

    enum status: %w[unavailable created started failed removed]
    # enum status: { unavailable: 0, created: 1, started: 2, failed: 3, removed: 4 }
      
    belongs_to :user
    has_and_belongs_to_many :tags
    has_and_belongs_to_many :networks    
end
