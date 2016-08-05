@students = []

def input_students
  puts "Please enter name followed by cohort month, to finish just hit return twice".center(120)
  puts "Please enter the name of the student".center(120)
  name = STDIN.gets.chomp.capitalize

	date_correct = false

  if name.empty?
    print_students
  end

	while date_correct == false
	 	puts "Please enter a cohort month using no abbreviations".center(120)
  		cohort = STDIN.gets.chomp.capitalize
		require 'date'
      if Date::MONTHNAMES.include? cohort
 	 			date_correct = true
			end
	end

	date_correct = false

	while !name.empty?
      students_to_list(name, cohort)
    	#@students << {name: name, cohort: cohort.to_sym}
        if @students.length == 1
          puts "Now we have #{@students.count} student".center(120)
          puts "Please enter the name of the student".center(120)
          name = STDIN.gets.chomp.capitalize
        else
          puts "Now we have #{@students.count} students".center(120)
    	    puts "Please enter the name of the student".center(120)
    	    name = STDIN.gets.chomp.capitalize
        end
    	if name.empty?
    		break
    	end
    		while date_correct == false
	 			puts "Please enter a cohort month using no abbreviations".center(120)
  				cohort = STDIN.gets.capitalize
          cohort = cohort.gsub(/\n/," ").strip
				require 'date'
					if Date::MONTHNAMES.include? cohort
						date_correct = true
					end
			  end
			date_correct = false
	end
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

def print_students

  if @students.count == 1
    puts "1. #{@students[0][:name]} (#{@students[0][:cohort]} cohort)".center(120)
  elsif @students.count >= 2
    puts "If you would you like to filter by cohort please type 'yes', otherwise hit return".center(120)
    answer = STDIN.gets.chomp.upcase
      if answer == "YES"
        cohort_groups = []
        puts @students
        cohort_groups << @students.group_by { |student| student[:cohort] }

          cohort_groups[0].each do |k,v|
     	        puts k.to_s.capitalize.center(120)
    		        v.each_with_index do |x, i|
    			           puts (x[:name] + " (" + k.to_s.capitalize + " cohort)").center(120)
    		        end
              end
      else
      counter = 0
        while @students.length >= counter+1
          puts "#{counter+1}. #{@students[counter][:name]} (#{@students[counter][:cohort]} cohort)".center(120)
          counter+=1
        end
      end
  else
    puts "There are no students to print".center(120)
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(120)
end

def save_students
  puts "Please enter the csv file name you would like to save this list to"
  filename = gets.chomp
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
  filename = gets.chomp

  if filename.empty?
    load_students("students.csv")
  elsif
    load_students(filename)
  else
    "sorry, file name doesn't exist"
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
