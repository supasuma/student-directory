
#First we put the students in an array
students = ["Dr. Hannibal Lecter",
"Darth Vader",
"Nurse Ratched",
"Michael Corleone",
"Alex DeLarge",
"The Wicked Witch of the West",
"Terminator",
"Freddy Krueger",
"The Joker",
"Joffrey Baratheon",
"Norman Bates"]
#and then print them
puts "The students of Villains Academy"
puts "-------------"
students.each do |student|
  puts student
end
#FInally we print the overall total of students
print "Overall, we have #{students.count} great students"
