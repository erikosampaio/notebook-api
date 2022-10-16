class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate#, :author

  belongs_to :kind do
    link(:kind) { kind_url(object.kind.id) }
  end
  has_many :phones
  has_one :address

  # Setting 'url' when to want using the complete path of the your site (App)
  link(:self) { contact_url(object.id) }
  link(:kind) { kind_url(object.kind.id) }

  meta do
    {
      author: "Sr. Ériko"
    }
  end

  def attributes(*args)
    h = super(*args)
    # ---> pt-BR <---h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end

  # Caso queria inserir um atributo virtual nos attributes
  # def author
  #   "Ériko Sampaio"
  # end
end
