@students = []

def input_students
  puts "Please enter name followed by cohort month, to finish just hit return twice".center(120)
  puts "Please enter the name of the student".center(120)
  name = STDIN.gets.chomp.capitalize

  return puts "You have entered no students".center(120) if name.empty?

  cohort = cohort_month

	while !name.empty?
    students_to_list(name, cohort)
    @students.length == 1 ? (puts "Now we have #{@students.count} student".center(120)) : (puts "Now we have #{@students.count} students".center(120))
    puts "Please enter the name of the student".center(120)
    name = STDIN.gets.chomp.capitalize
    return if name.empty?
    cohort = cohort_month
  end
end

def cohort_month
date_correct = false
  while date_correct == false
		puts "Please enter a cohort month using no abbreviations".center(120)
		cohort = STDIN.gets.chomp.capitalize
    require 'date'
    Date::MONTHNAMES.include?(cohort) ? date_correct = true : date_correct = false
	end
  return cohort
end

def students_to_list (name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    select_file
  when "9"
    exit
  else
    puts "I don't know what you mean, please try again"
  end
end

def print_menu
  puts "What would you like to do?"
  puts "1. Input students"
  puts "2. Show students"
  puts "3. Save students to a file"
  puts "4. Load a saved file"
  puts "9. Exit"
end

def show_students
  print_header
  print_students
  print_footer
end

#and then print them
def print_header
  puts "The students of Villains Academy".center(120)
  puts "-------------".center(120)
end

def filter_students
  cohort_groups = []
  cohort_groups << @students.group_by { |student| student[:cohort] }
  cohort_groups[0].each do |k,v|
    puts k.to_s.capitalize.center(120)
      v.each do |x|
        puts (x[:name] + " (" + k.to_s.capitalize + " cohort)").center(120)
      end
  end
end

def print_students
  puts "Would you like to filter by cohort please type 'yes', otherwise hit return".center(120)
  answer = STDIN.gets.chomp.upcase
  return filter_students if answer == "YES"

  if answer.empty?
    if @students.count >= 1
      @students.each.with_index(1) do |student, i|
        puts "#{i}. #{student[:name]} (#{student[:cohort]} cohort)".center(120)
      end
    else
      puts "There are no students to print".center(120)
    end
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(120)
end

def save_students
  puts "Please enter the csv file name you would like to save this list to"
  filename = STDIN.gets.chomp
  require 'csv'
    CSV.open(filename, "w") do |csv|
      @students.each do |student|
        student_data = [student[:name], student[:cohort]]
        # removed this line of code as CSV files take the information in arrays "csv_line = student_data.join(",")"
        csv.puts student_data
      end
    end

  #File.open(filename, "w") do |f|
  #  @students.each do |student|
  #    student_data = [student[:name], student[:cohort]]
  #    csv_line = student_data.join(",")
  #    f.puts csv_line
  #  end
  #end
  puts "You have #{@students.count} students saved"
end

def select_file
  puts "Please enter file name you'd like to load, otherwise hit enter and 'students.csv' will be loaded by default"
  filename = STDIN.gets.chomp

  if filename.empty?
    load_students("students.csv")
  elsif
    File.exists?(filename)
    load_students(filename)
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def load_students (filename)
  require 'csv'
  CSV.foreach(filename) do |row|
    name, cohort = row.join(",").chomp.split(",")
    students_to_list(name, cohort)
  end
puts "Loaded #{@students.count} students from #{filename}"
end

#def load_students (filename)
#  File.open(filename, "r") do |f|
#    while line = f.gets
#      name, cohort = line.chomp.split(",")
#      students_to_list(name, cohort)
#    end
#  puts "Loaded #{@students.count} students from #{filename}"
#  end
#end

def try_load_students
  filename = ARGV[0]
  return if filename.nil?

  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else
    puts "Sorry #{filename} doesn't exist."
    exit
  end
end

try_load_students
interactive_menu
