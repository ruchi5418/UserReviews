require "pstore" # https://github.com/ruby/pstore

STORE_NAME = "tendable.pstore"
store = PStore.new(STORE_NAME)

QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

# TODO: FULLY IMPLEMENT
def do_prompt(store)
  # Ask each question and get an answer from the user's input.
  answers = {}
  QUESTIONS.each_key do |question_key|
    answer = nil
    valid_answers = ["yes", "no", "y", "n"]
    loop do  # loops over each quetion, get answer for each question and push in to the answers hash
      print "#{QUESTIONS[question_key]} (Yes/No): "
      answer = gets.chomp.strip.downcase
      break if valid_answers.include?(answer)
      puts "Invalid input. Please answer Yes or No (Y/N)."
    end
    answers[question_key] = answer.start_with?('y') ? "Yes" : "No"
  end

  # Store the answers given by user to pstore
  store.transaction do
    store[:runs] ||= []
    store[:runs] << answers
  end
  answers
end

# calculate average rating for each run
def current_run_rating(answers)
  yes_count = answers.values.count { |answer| answer == "Yes" }
  (100.0 * yes_count / QUESTIONS.size).round(2)
end

# calculate average rating for all the runs stored in ptore
def calculate_average_rating(store)
  total_yes = 0
  total_answers = 0

  store.transaction(true) do
    runs = store[:runs] || []
    runs.each do |run|
      total_yes += run.values.count { |answer| answer == "Yes" }
      total_answers += QUESTIONS.size
    end
  end

  (100.0 * total_yes / total_answers).round(2)
end

def do_report(store, current_run_rating)
  average_rating = calculate_average_rating(store)
  puts "Your rating for this run: #{current_run_rating}%"
  puts "Average rating for all runs: #{average_rating}%"
end


answers = do_prompt(store)
current_run_rating = current_run_rating(answers)
do_report(store, current_run_rating)

