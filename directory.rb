

def input_students
  puts "Please enter the name of the students"
  puts "To finish, just hit return twice"

  students = []

  name = gets.chomp

  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name = gets.chomp
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

def print_students (students_with_short_names)
  puts "Would you like to filter students by the letter of their first name?"
  puts "If so, please enter the letter, otherwise hit enter"
  letter = gets.chomp
#If user has entered a letter want to get students array of hashes and access first hash of array
#access name key and ask whether the string starts with letter puts only those names
#PROBLEM - probably don't want print_footer when filtering, OR want a different footer that counts those with partic letter.
    if !letter.empty?
      students_with_short_names.each_with_index do |student, i|
        if student[:name].start_with?(letter)
           puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)"
        end
      end
    else
      students_with_short_names.each_with_index do |student, i|
      puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
    end
end
#FInally we print the overall total of students
def print_footer(students)
  print "Overall, we have #{students.count} great students, but above are those "
  puts "with names of less than 12 characters and/or those students filtered by the letter of their first name."
end

students = input_students
print_header
short_names(students, students_with_short_names)
print_students(students_with_short_names)
print_footer(students)
