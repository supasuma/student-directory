

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
  puts "Would you like to filter students by the letter of their first name?"
  puts "If so, please enter the letter, otherwise hit enter"
  letter = gets.chomp
#If user has entered a letter want to get students array of hashes and access first hash of array
#access name key and ask whether the string starts with letter puts only those names
#PROBLEM - probably don't want print_footer when filtering, OR want a different footer that counts those with partic letter.
    if !letter.empty?
      students.each_with_index do |student, i|
        if student[:name].start_with?(letter)
           puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)"
        end
      end
    else
      students.each_with_index do |student, i|
      puts "#{i+1}. #{student[:name]} (#{student[:cohort]} cohort)"
      end
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
