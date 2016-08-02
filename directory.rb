

def input_students
  puts "Please enter the name of the students"
  puts "To finish, just hit return twice"

  students = []

  name = gets.chomp.capitalize

  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp.capitalize
  end
students
end
#and then print them
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
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
 puts "Would you like to filter students by the letter of their first name?"
 puts "If so, please enter the letter, otherwise hit enter"
 letter = gets.chomp.upcase
 	if !letter.empty?
  		filter_by_letter(student_array, letter)
  else
		counter = 0
		while student_array.length >= counter+1
			puts "#{counter+1}. #{student_array[0+counter][:name]} (#{student_array[0+counter][:cohort]} cohort)"
			counter+=1
		end
	end
end

def filter_by_letter(student_array, letter)
	counter = 0
	while student_array.length >= counter+1
		if student_array[counter][:name].start_with?(letter)
           puts "#{counter+1}. #{student_array[0+counter][:name]} (#{student_array[0+counter][:cohort]} cohort)"
        end
    counter+=1
    end
end
#FInally we print the overall total of students
def print_footer(students)
  print "Overall, we have #{students.count} great students, but above are those "
  puts "with names of less than 12 characters (and filtered first name letter if you selected that option)."
end

students = input_students
print_header
short_names(students, students_with_short_names)
print_students(students_with_short_names)
print_footer(students)
