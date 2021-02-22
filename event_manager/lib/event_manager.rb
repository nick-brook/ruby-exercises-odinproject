# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

# cleans up zip code
def clean_zip_code(zip_code)
  zip_code.to_s.rjust(5, '0')[0..4]
end

def clean_number(number)
  num = number.to_s.gsub(/\D/, '')
  if num.length == 10
    num
  elsif num.length == 11 && num[0] == '1'
    num.slice(1, 10)
  else
    'Bad Number'
  end
end

# access the senate and house representatives for a given zip code returns array of legislatures
def legislator_name(zip_code)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip_code,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'you can look it up yourself by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

# create directory and add a file for each participant
def save_letter_file(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def get_hour(date_time)
  Time.strptime(date_time, '%m/%d/%y %k:%M').hour
end

def get_day_of_week(date_time)
  Time.strptime(date_time, '%m/%d/%y %k:%M').wday
end

# method analyses array to identify most popular element(s)
def popular_element(time_arr)
  res_arr = [[0, 0]]
  array_to_hash(time_arr)
    .each_pair do |hour, number|
    if number > res_arr[0][1]
      res_arr = [[hour, number]]
    elsif number == res_arr[0][1]
      res_arr.push([hour, number])
    end
  end
  res_arr
end

# turn array into hash - keys are array elemnt values, hash value is number of instances in array
def array_to_hash(time_arr)
  res_hash = {}
  time_arr.each do |item|
    if res_hash.key?(item)
      res_hash[item] += 1
    else
      res_hash[item] = 1
    end
  end
  res_hash
end

# each line of a file converrted to an array element
contents = CSV.open('event_attendees.csv',
                    headers: true,
                    header_converters: :symbol)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

time_arr = []
day_arr = []

# output each aray element
contents.each do |line|
  id = line[0]
  first_name = line[:first_name]
  zip_code = clean_zip_code(line[:zipcode])
  # p line[:homephone]
  number = clean_number(line[:homephone])
  time_arr.push(get_hour(line[:regdate]))
  day_arr.push(get_day_of_week(line[:regdate]))
  legislators = legislator_name(zip_code)
  # personal_letter = template_letter.gsub('FIRST_NAME', first_name)
  # personal_letter.gsub!('LEGISLATORS', name_str)
  # puts personal_letter
  # template_letter = File.read('form_letter.html')
  # erb_template = ERB.new template_letter
  form_letter = erb_template.result(binding)
  save_letter_file(id, form_letter)
end

p Date::DAYNAMES[popular_element(day_arr)[0][0]]
p popular_element(time_arr)
