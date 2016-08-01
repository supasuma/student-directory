

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

def print_students(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end
#FInally we print the overall total of students
def print_footer(students)
  puts "Overall, we have #{students.count} great students."
end

students = input_students
print_header
print_students(students)
print_footer(students)
