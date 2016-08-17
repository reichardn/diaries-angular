class EntrySerializer < ActiveModel::Serializer
  attributes :id, :day, :minutes
  has_one :project
end
