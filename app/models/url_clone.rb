class UrlClone
  attr_accessor :link, :_alias
  
  def initialize(attributes = {})
    @link = attributes['link']
    @_alias = attributes['_alias']
  end
end