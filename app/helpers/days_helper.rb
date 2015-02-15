module DaysHelper
  def get_appropriate_weight_units unit_string
    case unit_string
    when 'UK' then ' Stone'
    when 'US' then 'lbs'
    else 'KG'
    end
  end
end