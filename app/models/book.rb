class Book < ActiveRecord::Base
  validates :title, presence: true

  def self.to_csv
    attributes = %w[id created_at title utitle isbn iucat purchase
                    course name email status campus department]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |book|
        csv << book.attributes.values_at(*attributes)
      end
    end
  end
end
