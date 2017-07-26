require 'csv'

class CsvParser
  include Service

  def initialize(users)
    @users = users
    @user_fields = %w[email age gender]
    @interest_fields = %w[name interest_type]
    @width = biggest_amount_of_children
  end

  def execute
    CSV.generate(headers: true) do |csv|
      csv << parsed_header
      @users&.each do |user|
        row = user.attributes.slice(*@user_fields).values
        row += user.interests.map { |interest| interest.slice(*@interest_fields).values }
        csv << row.flatten
      end
    end
  end

  private

  def biggest_amount_of_children
    return 0 if @users.nil?
    return 1 unless @users.is_a? Array
    @users.left_joins(:interests).group(:id).order('COUNT(interests.id) DESC').limit(1).first.interests.count
  end

  def parsed_header
    0.upto(@width).inject(Array.new(@user_fields)) do |header, number|
      header + @interest_fields.map { |field_name| "#{field_name}#{number}" }
    end
  end
end
