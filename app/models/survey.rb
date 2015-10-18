class Survey < ActiveRecord::Base
	has_many :questions, :dependent => :destroy
	has_many :feedbacks, :dependent => :destroy
	accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:title].blank? }, :allow_destroy => true
end
