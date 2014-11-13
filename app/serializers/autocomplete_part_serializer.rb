class AutocompletePartSerializer < ActiveModel::Serializer
  attributes :id, :text

  def id
    object.part_id
  end

  def text
    object.calculated_name
  end
end
