class PhonesController < ApplicationController
  before_action :set_phones

  def show
    render json: @phones
  end

  def set_phones
    @phones = Contact.find(params[:contact_id]).phones
  end
end
