class Shipment < ActiveRecord::Base

  UNIT_CBM = 167

  SL1_RATES = {
      'Australia' => 30,
      'Singapore/Taiwan/China'  => 25,
      'America'   => 20,
      'Europe'    => 15,
  }
  SL2_RATES = {
      'Australia' => 15,
      'Singapore/Taiwan/China'  => 12.50,
      'America'   => 10,
      'Europe'    => 7.5,
  }
  SL3_RATES = {
      'Australia' => 15,
      'Singapore/Taiwan/China'  => 12.50,
      'America'   => 10,
      'Europe'    => 7.5,
  }

  belongs_to :user

  before_save :calculate_cbm

  def calculate_cbm
    self.tracking_code = SecureRandom.base64(8)
    len = length/100
    wid = width/100
    hei = height/100
    volume = len*wid*hei
    total_volume = no_of_products * volume
    taxable_weight = total_volume * UNIT_CBM
    if taxable_weight > self.weight
      self.quotation = calculate_quotation(taxable_weight, self.origin, self.service_level)
    else
      self.quotation = calculate_quotation(self.weight, self.origin, self.service_level)
    end
    self.cbm = total_volume
    unless self.status.present?
      self.status = "pending"
    end

  end

  def calculate_quotation(weight, origin, service_level)
    quotation = 0
    case origin
    when 'Australia'
      if service_level === "SL1"
        quotation = weight * SL1_RATES['Australia']
      else
        quotation = weight * SL2_RATES['Australia']
      end

    when 'Singapore/Taiwan/China'
      if service_level === "SL1"
        quotation = weight * SL1_RATES['Singapore/Taiwan/China']
      else
        quotation = weight * SL2_RATES['Singapore/Taiwan/China']
      end
    when 'America'
      if service_level === "SL1"
        quotation = weight * SL1_RATES['America']
      else
        quotation = weight * SL2_RATES['America']
      end
    when 'Europe'
      if service_level === "SL1"
        quotation = weight * SL1_RATES['Europe']
      else
        quotation = weight * SL2_RATES['Europe']
      end
    end
    quotation
  end
end
