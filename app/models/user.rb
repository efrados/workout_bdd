class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :exercises, dependent: :destroy
  validates_presence_of :first_name, :last_name

  def full_name
   "#{first_name} #{last_name}" 
  end
  scope :with_one_name, ->(one_name){ where('LOWER(first_name) LIKE :name OR LOWER(last_name) LIKE :name', name: "%#{one_name.downcase}%") }
  scope :with_two_names, ->(first, second){ where('((LOWER(first_name) LIKE :full_name ) OR (LOWER(last_name) LIKE :full_name)) OR (LOWER(first_name) LIKE :other_name AND LOWER(last_name) LIKE :name ) OR (LOWER(first_name) LIKE :name AND LOWER(last_name) LIKE :other_name)',
 name: "%#{first.downcase}%", other_name: "%#{second.downcase}%", full_name: "%#{first.downcase} #{second.downcase}%") }
  def self.search(names)
    if !names.present?
      users = User.all
    else
      name_array = names.split(' ')
      if name_array.size == 1
        users = User.with_one_name(names)
      else
        users = User.with_two_names(name_array[0], name_array[1])
      end
    end
    users
  end
end
