# == Schema Information
#
# Table name: cards
#
#  id                    :integer          not null, primary key
#  phone                 :string(255)
#  general_email_address :string(255)
#  website_url           :string(255)
#  twitter_username      :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  cardable_id           :integer
#  cardable_type         :string(255)
#  blog_url              :string(255)
#  personal_url          :string(255)
#

class Card < ActiveRecord::Base
  include Authority::Abilities
  resourcify

  before_save :strip_twitter_username, if: :twitter_username_changed?

  attr_accessible :general_email_address,
                  :phone,
                  :twitter_username,
                  :website_url,
                  :blog_url,
                  :personal_url

  belongs_to :cardable, polymorphic: true

  validates :general_email_address, length: { maximum: 255 }, allow_nil: true
  validates :phone, numericality: { only_integer: true }, allow_blank: true
  validates :twitter_username, length: { maximum: 15 }, allow_nil: true
  # validates :website_url

  def strip_twitter_username
    twitter_username.gsub!("@","")
  end

  def link_to_website
    http_site self.website_url
  end

  def link_to_blog
    http_site self.blog_url
  end

  private
  def http_site website
    return "http://#{website}" unless website.starts_with?("http") || website.starts_with?("http")
    website
  end
end
