class Public::CustomerParameterSanitizer < Devise::ParameterSanitizer
  
  
  
  def initialize(*)
       super
   permit(:sign_up, keys: [:email,:password,:last_name,:first_name,:last_name_kana,:first_name_kana,:postal_code,:address,:telephone_number,:is_deleted])
  end
end