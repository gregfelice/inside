module PeopleHelper

  def b(field)
    if field.nil? || field.size == 0
      '.'
    else
      field
    end
  end

end
