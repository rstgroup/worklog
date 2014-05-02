class AutocompletePartSerializer < ActiveModel::Serializer
  attributes :value

  def value
    object.calculated_name
  end
end
