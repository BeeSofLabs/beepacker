class API::BaseSerializer < ActiveModel::Serializer
  def initialize(object, options={})
  
    @extra = options[:extra].present?
    @message = options[:message]
    super(object)
  end
end