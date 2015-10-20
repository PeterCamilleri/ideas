# A random, epic, excuse generator in Ruby!
# For those times that you just need to cop out.

HEAD = ["I'm sorry but",
        "Please forgive me;",
        "I beg you a thousand pardons;",
        "I apologize, however",
        "I'm never usually like this;",
        "You're never going to believe this;",
        "Guess what happened?!?",
        "Holy Shit! Get this:",
        "Boy do I have a story for you;",
        "So I was minding my own business and boom!",
        "The most unbelievable thing just happened;",
        "I couldn't be more apologetic but",
        "Sorry I'm late;",
        "I couldn't go because",
        "I couldn't help it;",
        "This is a terrible excuse but",
        "This is going to sound crazy but",
        "Holy Moses!",
        "Blimey! Sorry I'm late guv'nha but",
        "My bad;",
        "I swear it wasn't my fault,",
        "I lost track of time because",
        "I feel terrible, but",
        "Don't blame me;"
       ]

MID  = ["your mom",
        "Princess Peach",
        "Godzilla",
        "the offensive line of the `76 Dallas Cowboys",
        "a handicapped gentleman",
        "a triceratops named Penelope",
        "the inventor of the Slanket",
        "the director of 101 Dalmations",
        "the little Asian kid from Indiana Jones",
        "a man with six fingers on his right hand",
        "my mom",
        "Raiden from Mortal Kombat",
        "Mayor McCheese",
        "Scrooge McDuck",
        "the ghost of Margaret Thatcher",
        "the ghost of Hitler",
        "the entire Roman Empire",
        "Ghost Dad",
        "your Sky Daddy",
        "Kevin Ware's leg bone",
        "a British chap",
        "a Hasidic Jew",
        "Kevin Spacey",
        "Kevin Costner's stunt double",
        "Kevin McCallister's real life fake tarantula",
        "the editors of Mandatory"
       ]

TAIL = ["gave me a hickey",
        "tried to kill me",
        "ran me over with a diesel backhoe",
        "died in front of me",
        "ate my homework",
        "tried to seduce me",
        "beat me into submission",
        "hid my Trapper Keeper",
        "stole my bicycle",
        "slept with my uncle",
        "called me \"Too gay to fly a kite,\" whatever that means",
        "stole my identity",
        "broke into my house",
        "put me in a Chinese finger trap",
        "came after me",
        "came on to me",
        "texted racial slurs from my phone",
        "spin kicked me in the collar bone",
        "tried to sell me a vacuum cleaner",
        "crapped in my gas tank",
        "made me golf in shoes filled with macaroni and cheese",
        "pulled me over in a stolen police car and demanded fellatio",
        "made me find Jesus",
        "kept telling me knock knock jokes"
       ]

def excuse
  head = HEAD[rand(HEAD.length)]
  mid  = MID[rand(HEAD.length)]
  tail = TAIL[rand(HEAD.length)]

  "#{head} #{mid} #{tail}."
end

if (count = ARGV[0].to_i) == 0
  count = 1
end

count.times do
  puts excuse
  puts
end

