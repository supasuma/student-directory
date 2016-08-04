@students = []

def input_students
  puts "Please enter name followed by cohort month, to finish just hit return twice".center(120)
  puts "Please enter the name of the student".center(120)
   name = gets.capitalize
   name = name.gsub(/\n/," ").strip

	date_correct = false

  if name.empty?
    print_students####################
  end

	while date_correct == false
	 	puts "Please enter a cohort month using no abbreviations".center(120)
  		cohort = gets.capitalize
      cohort = cohort.gsub(/\n/," ").strip
		require 'date'
      if Date::MONTHNAMES.include? cohort
 	 			date_correct = true
			end
		end

	date_correct = false

	while !name.empty?
    	@students << {name: name, cohort: cohort.to_sym}
        if @students.length == 1
          puts "Now we have #{@students.count} student".center(120)
          puts "Please enter the name of the student".center(120)
          name = gets.capitalize
          name = name.gsub(/\n/," ").strip
        else
          puts "Now we have #{@students.count} students".center(120)
    	    puts "Please enter the name of the student".center(120)
    	    name = gets.capitalize
          name = name.gsub(/\n/," ").strip
        end
    	if name.empty?
    		break
    	end
    		while date_correct == false
	 			puts "Please enter a cohort month using no abbreviations".center(120)
  				cohort = gets.capitalize
          cohort = cohort.gsub(/\n/," ").strip
				require 'date'
					if Date::MONTHNAMES.include? cohort
						date_correct = true
					end
			  end
			date_correct = false
	end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
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

#students_with_short_names = []

#def short_names (students, students_with_short_names)
#  students.each do |student|
#    if student[:name].length < 12
#        students_with_short_names << student
#push all names shorter than 12 to new array to be passed to print_students
#if name is longer than 12 do nothing with the name
#    end
#  end
#end

def print_students
# puts "Would you like to filter students by the letter of their first name?".center(120)
# puts "If so, please enter the letter, otherwise hit enter".center(120)
# letter = gets.chomp.upcase
# 	if !letter.empty?
#  		filter_by_letter(@students, letter)

#  else
  if @students.count == 1
    puts "1. #{@students[0][:name]} (#{@students[0][:cohort]} cohort)".center(120)
  elsif @students.count >= 2
    puts "If you would you like to filter by cohort please type 'yes', otherwise hit return".center(120)
    answer = gets.chomp.upcase
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
          puts "#{counter+1}. #{@students[0+counter][:name]} (#{@students[0+counter][:cohort]} cohort)".center(120)
          counter+=1
        end
      end
  else
    puts "There are no students to print".center(120)
  end
end

#def filter_by_letter(@students, letter)
#	counter = 0
#	while @students.length >= counter+1
#		if @students[counter][:name].start_with?(letter)
#           puts "#{counter+1}. #{@students[0+counter][:name]} (#{@students[0+counter][:cohort]} cohort)".center(120)
#           puts
#        end
#    counter+=1
#    end
#end

#FInally we print the overall total of students
def print_footer
  puts "Overall, we have #{@students.count} great students".center(120) #but above are those with names
  #puts of less than 12 characters (and filtered by first name letter if you selected that option).".center(120)
end

interactive_menu
#@students = input_students
#print_header
#short_names(@students, students_with_short_names)
#print_students(@students)
#print_footer(@students)
