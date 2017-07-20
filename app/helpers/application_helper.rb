module ApplicationHelper
  def parsed_interest_types
    Interest.interest_types.keys.map { |type| [type.humanize, type] }
  end

  def parsed_genders
    User.genders.keys.map { |gender| [gender.humanize, gender] }
  end
end
