

def input_students
  puts "Please enter name followed by cohort month, to finish just hit return twice".center(120)
  puts "Please enter the name of the student".center(120)
   name = gets.chomp.capitalize

	students = []
	date_correct = false

	while date_correct == false
	 	puts "Please enter a cohort month using no abbreviations".center(120)
  		cohort = gets.chomp.capitalize
		require 'date'
			if (Date.parse(cohort) rescue false)
 	 			date_correct = true
			end
		end

	date_correct = false

	while !name.empty?
    	students << {name: name, cohort: cohort}
    	puts "Now we have #{students.count} students".center(120)
    	puts "Please enter the name of the student".center(120)
    	name = gets.chomp.capitalize
    	if name.empty?
    		break
    	end
    		while date_correct == false
	 			puts "Please enter a cohort month using no abbreviations".center(120)
  				cohort = gets.chomp.capitalize
				require 'date'
					if (Date.parse(cohort) rescue false)
						date_correct = true
					end
			  end
			date_correct = false
	end
students
end

#and then print them
def print_header
  puts "The students of Villains Academy".center(120)
  puts "-------------".center(120)
end

students_with_short_names = []

def short_names (students, students_with_short_names)
  students.each do |student|
    if student[:name].length < 12
        students_with_short_names << student
#push all names shorter than 12 to new array to be passed to print_students
#if name is longer than 12 do nothing with the name
    end
  end
end

def print_students (student_array)
 puts "Would you like to filter students by the letter of their first name?".center(120)
 puts "If so, please enter the letter, otherwise hit enter".center(120)
 letter = gets.chomp.upcase
 	if !letter.empty?
  		filter_by_letter(student_array, letter)
  else
		counter = 0
		while student_array.length >= counter+1
			puts "#{counter+1}. #{student_array[0+counter][:name]} (#{student_array[0+counter][:cohort]} cohort)".center(120)
      puts
			counter+=1
		end
	end
end

def filter_by_letter(student_array, letter)
	counter = 0
	while student_array.length >= counter+1
		if student_array[counter][:name].start_with?(letter)
           puts "#{counter+1}. #{student_array[0+counter][:name]} (#{student_array[0+counter][:cohort]} cohort)".center(120)
           puts
        end
    counter+=1
    end
end
#FInally we print the overall total of students
def print_footer(students)
  puts "Overall, we have #{students.count} great students, but above are those with names of ".center(120)
  puts "less than 12 characters (and filtered by first name letter if you selected that option).".center(120)
end

students = input_students
print_header
short_names(students, students_with_short_names)
print_students(students_with_short_names)
print_footer(students)
