# == Schema Information
#
# Table name: companies
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  description         :text
#  category            :string(255)
#  founded_in          :integer
#  number_of_employees :integer
#  kvk_number          :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  websites            :hstore
#  logo                :string(255)
#  category_id         :integer
#  published           :boolean          default(TRUE)
#  cached_slug         :string(255)
#

class Company < ActiveRecord::Base
  include Authority::Abilities
  resourcify
  is_sluggable :name
  scope :published, where(published: true)

  serialize :websites, ActiveRecord::Coders::Hstore

  attr_accessible :description,
  :founded_in,
  :kvk_number,
  :name,
  :number_of_employees,
  :card_attributes,
  :location_attributes,
  :products_attributes,
  :specialities,
  :logo,
  :logo_cache,
  :blog,
  :published,
  :person_ids

  # hstore_accessor :websites, :corporate, :blog
  # oneindig adressen, met keuzelijst label corporate / blog

  has_one :card, as: :cardable
  has_one :location, as: :locatable
  has_many :products, as: :productable
  has_many :images, as: :imageable
  belongs_to :category
  has_many :jobs
  has_and_belongs_to_many :people

  mount_uploader :logo, ImageUploader

  accepts_nested_attributes_for :card, update_only: true
  accepts_nested_attributes_for :location, update_only: true
  accepts_nested_attributes_for :products, reject_if: :all_blank, allow_destroy: true

  attr_taggable :specialities

  validates :name, length: { maximum: 255 }, presence: true, uniqueness: true
  validates :description, presence: true
  validates :founded_in, numericality: { only_integer: true }, length: { is: 4 }, allow_blank: true
  validates :kvk_number, length: { is: 8 }, numericality: { only_integer: true }, allow_blank: true, uniqueness: true
  validates :number_of_employees, numericality: { only_integer: true }, allow_blank: true

  def self.popular_tags_list
    tags ||= Company.tags.collect(&:name).sort
    tags
  end

end
