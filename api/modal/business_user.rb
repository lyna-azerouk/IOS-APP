require_relative 'user'
require 'active_record'

class BusinessUser < User

  belongs_to :controller, required: false

  validates :business_type, :business_name, :business_classification, presence: true
  validates :controller, presence: true, if: :controller_presence?

  enumerize :business_type, in: [:llc, :soleProprietorship, :partnership, :corporation]

  def build_dwolla_body
    super.merge!(
      :businessClassification => business_classification,
      :businessType => business_type,
      :businessName => business_name,
      :ein => ein
    )
  end

  def build_dwolla_body_with_controller
    build_dwolla_body().merge!(
      :controller => build_controller()
    )
  end

  def build_controller
    {
      :firstName => controller.first_name,
      :lastName => controller.last_name,
      :title => controller.title,
      :dateOfBirth => controller.date_of_birth,
      :ssn => controller.ssn,
      :address => {
        address1: controller.address.street,
        city: controller.address.city,
        stateProvinceRegion: controller.address.region,
        postalCode: controller.address.postal_code,
        country:  controller.address.country
    }
    }
  end

  def create_verfied_user_dowlla_api
    self.init_dwolla()

    request_body =
      case business_type
      when "llc"
        build_dwolla_body_with_controller()
      else
        build_dwolla_body()
      end

    @dwolla.create_verifed_user(request_body)
  end

  def controller_presence?
    ["llc", "corporation", "partnership"].include?(self.business_type)
  end
end