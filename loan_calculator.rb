# => loan_calculator.rb
# => January 15, 2019

require 'pry'
require 'yaml'

# => begin global references

MESSAGES = YAML.load_file('loan_calculator.yml')


# => begin method declarations

def format_msg(message_string)
  puts "|==>  #{message_string}"
end

def solicit_loan_amount
  input_is_valid = nil
  until input_is_valid == true

    format_msg(MESSAGES['prompt_loan_amount'])
    amount_string = gets.chomp
    valid = validate_loan_amount(amount_string)

    if valid
      return loan_str_to_num(amount_string)
    else
      format_msg(MESSAGES['loan_amount_invalid'])
    end
  end
end

def solicit_user_input(prompt_msg)
  format_msg(prompt_msg)
  gets.chomp
end

def send_user_msg(msg_to_user)
  format_msg(msg_to_user)
  gets.chomp
end

def get_user_loan_amount
  loop do  
    amount_string = solicit_user_input(MESSAGES['prompt_loan_amount'])
    if validate_loan_amount(amount_string) == true
      #loan_amount is valid - convert to numeric type for math calc & return
      return loan_str_to_num(amount_string)
    else
      send_user_msg(MESSAGES['loan_amount_invalid'])    
      amount_string = solicit_user_input(MESSAGES['prompt_loan_amount'])
    end
  end
end

def validate_loan_amount(loan_amount)
  loan_amount.delete!('$,')
  loan_amount.match?(/\A[0-9]+\.?[0-9]*\z/)
end

def loan_str_to_num(loan_amount)
  numeric_loan_amount = "%0.2f" %[loan_amount]
  return numeric_loan_amount
end



# => begin procedural code
format_msg(MESSAGES['welcome'])

loop do
  format_msg(MESSAGES['prompt_to_use'])
  yes_to_use = gets.chomp

  if yes_to_use.downcase != 'y' then break end

  loan_principle = nil
  loan_term_months = nil
  loan_rate_percent = nil

  # prompt for loan_amount
  loan_principle = get_user_loan_amount

  puts loan_principle


  # prompt for loan_duration

  #validate

  # prompt for loan interest_rate

  #validate

  puts 'will i get here?'
  binding.pry



end

puts "Bye!"
