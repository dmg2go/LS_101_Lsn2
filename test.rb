

advice = "Few things in life are as important as house training your pet dinosaur."

advice.sub!('important', 'urgent')

p advice

ary = ''

advice.split.map! do |w|
  p w
  if w == 'important'
    ary << 'urgent '
  else
    ary << "#{w} "
  end
end

p ary
advice = ary.strip

p advice


def add_eight(number)
  number + 8
end

number = 2

how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }


p "1. how_deep is: #{how_deep}"

p "2. eval(how_deep) is: #{eval(how_deep)}"



flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
flintstones.flatten!
p flintstones



flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
ary = flintstones.assoc("Barney")
p ary
p flintstones