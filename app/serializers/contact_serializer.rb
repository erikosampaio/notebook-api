class ContactSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :birthdate

  belongs_to :kind
  has_many :phones
  has_one :address

  def attributes(*args)
    h = super(*args)
    # ---> pt-BR <---h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end

  # Example
  # contact = Contact.last
  # hash = ContactSerializer.new(contact).serializable_hash
  # json = hash.to_json
end
