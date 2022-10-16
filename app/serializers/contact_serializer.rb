class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate#, :author

  belongs_to :kind
  has_many :phones
  has_one :address

  # Caso queria inserir um atributo virtual nos attributes
  # def author
  #   "Ériko Sampaio"
  # end

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
end
