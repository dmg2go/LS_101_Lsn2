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

def solicit_user_input(prompt_msg)
  format_msg(prompt_msg)
  gets.chomp
end

def send_user_msg(msg_to_user)
  format_msg(msg_to_user)
end

def get_user_loan_amount
  loop do  
    amount_string = solicit_user_input(MESSAGES['prompt_loan_amount'])
    
    if validate_loan_amount(amount_string) == true
      return loan_amnt_string_to_num(amount_string)
    else
      send_user_msg(MESSAGES['loan_amount_invalid'])
      next
    end
  end
end

def validate_loan_amount(loan_amount)
  loan_amount.delete!('$,')
  loan_amount.match?(/\A[0-9]+\.?[0-9]*\z/)
end

def loan_amnt_string_to_num(loan_amount)
  numeric_loan_amount = "%0.2f" %[loan_amount]
  return numeric_loan_amount.to_f
end

def get_user_loan_duration
  loop do
    duration_string = solicit_user_input(MESSAGES['prompt_loan_duration'])

    if validate_loan_duration(duration_string) == true
      return duration_string.to_i
    else
      send_user_msg(MESSAGES['loan_duration_invalid'])
    end

  end
end

def validate_loan_duration(loan_duration)
  loan_duration.match?(/\A[0-9]+\z/)
end

def get_monthly_interest_rate
  loop do  
    int_rate_string = solicit_user_input(MESSAGES['prompt_loan_rate'])
    
    if validate_loan_rate(int_rate_string) == true
      #binding.pry
      return loan_rate_string_to_num(int_rate_string)
    else
      send_user_msg(MESSAGES['loan_rate_invalid'])
      next
    end
  end
end

def validate_loan_rate(int_rate_string)
  int_rate_string.delete!('% ')
  int_rate_string.match?(/\A[0-9]+\.?[0-9]*\z/)
end

def loan_rate_string_to_num(int_rate_string)
numeric_annual_rate = ("%0.2f" %[int_rate_string]).to_f/100
numeric_month_rate = numeric_annual_rate/12.round(4)
end

# => begin procedural code
send_user_msg(MESSAGES['welcome'])

loop do
  yes_to_use = solicit_user_input(MESSAGES['prompt_to_use'])

  if yes_to_use.downcase != 'y' then break end

  loan_principle = get_user_loan_amount
  loan_term_months = get_user_loan_duration
  monthly_interest_rate = get_monthly_interest_rate

  loan_terms_display = <<~OUT
        The terms of this loan are as follows:

    |==>>  loan principle:     $#{format('%02.2f', loan_principle)}
    |==>>  loan term (months):  #{loan_term_months}
    |==>>  interest rate (APR): #{format('%02.2f', (monthly_interest_rate * 100 * 12))}%

  OUT

  binding.pry
  mo_payment = loan_principle * 
                (monthly_interest_rate / 
                (1 - (1 + monthly_interest_rate)**(-loan_term_months)))
  send_user_msg(loan_terms_display)
  send_user_msg(MESSAGES['report_monthly_payment'] + "#{format('%02.2f', mo_payment)}")
end

send_user_msg(MESSAGES['goodbye'])
