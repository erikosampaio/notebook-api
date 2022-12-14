module V1
  class ContactSerializer < ActiveModel::Serializer
    attributes :id, :name, :email, :birthdate#, :author

    belongs_to :kind do
      link(:related) { v1_contact_kind_url(object.id) }
    end
    has_many :phones do
      link(:related) { v1_contact_phones_url(object.id) }
    end

    has_one :address do
      link(:related) { v1_contact_address_url(object.id) }
    end

    # Setting 'url' when to want using the complete path of the your site (App)
    # link(:self) { contact_url(object.id) }
    # link(:kind) { kind_url(object.kind.id) }

    # Using virtual attributes for all the actions
    # meta do 
    #   {
    #     author: "Sr. Ériko"
    #   }
    # end

    def attributes(*args)
      h = super(*args)
      # ---> pt-BR <---h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
      h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
      h
    end

    # Using virtual attributes for the action then callhim
    # def author
    #   "Ériko Sampaio"
    # end
  end
end