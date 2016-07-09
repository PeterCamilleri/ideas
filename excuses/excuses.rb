# A random, epic, excuse generator in Ruby!
# For those times that you just need to cop out.

class Excuse
  REMIX = 50

  HEAD = ["I'm sorry but",
          "Please forgive me;",
          "I beg you a thousand pardons;",
          "I apologize, however",
          "I'm never usually like this;",
          "You're never going to believe this;",
          "Guess what happened?!?",
          "Holy Shit! Get this:",
          "Sacra Merde! Get this:",
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
          "Oh my god!",
          "Oh my gosh!",
          "It's not my fault!",
          "Who could believe it!",
          "Look, this day has gotten off to a rocky start;",
          "Please try to be reasonable;",
          "This isn't what it looks like;",
          "A funny thing happened on the way to the forum;",
          "Holy Moley",
          "Don't blame me;"
         ]

  MID  = ["your mom",
          "Princess Peach",
          "GlaDOS",
          "Rob Ford",
          "Godzilla",
          "Count Dracula",
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
          "Barrack Obama",
          "Donald Trump",
          "Sarah Palin",
          "Hillary Clinton",
          "Chell from Portal",
          "Dom DeLuise",
          "Tom Hanks",
          "Thom of Finland",
          "the Roman Curia",
          "the ghost of Margaret Thatcher",
          "the ghost of Adolf Hitler",
          "the ghost of Winston Churchill's cigar supplier",
          "the entire Roman Empire",
          "a group of ISIS terrorists",
          "an angry mob of republicans",
          "a solar energy lobbyist",
          "the entire Green party of Germany",
          "the ghost of Sir John A McDonald's hair dresser",
          "your Ghost Daddy",
          "your Sky Daddy",
          "your imaginary Sky Friend",
          "the Flying Spaghetti Monster",
          "the clone of Adolf Hitler",
          "Kevin Ware's leg bone",
          "a British chap",
          "a Hasidic Jew",
          "Kevin Spacey",
          "Kevin Costner's stunt double",
          "Kevin McCallister's real life fake tarantula",
          "the Antea Cement company of Albania",
          "Italian sprinter Irene Siragusa",
          "the surviving members of the Beatles",
          "the US ambassador to Sweden",
          "all the staff of Heathrow Terminal 4",
          "Albert Einstein",
          "the evil committee that demoted Pluto",
          "Sherlock Holmes' smarter brother",
          "the Spanish Inquisition",
          "the entire Green Party of Canada",
          "the entire population of Norway",
          "some players resting during a break in a very long cricket match",
          "the ghosts of the last winning Toronto Maple Leafs hockey team",
          "Martha Stewart's nice-human-persona stunt double",
          "Forrest Gump",
          "Batman",
          "Robin",
          "Donald Trump's gross comb-over",
          "Spiderman",
          "Linus Torvalds",
          "a very old but self-aware Macintosh computer",
          "the editors of Mandatory.com"
         ]

  TAIL = ["gave me a hickey",
          "tried to kill me",
          "ran me over with a diesel backhoe",
          "died right in front of me",
          "demanded narcotics of me",
          "demanded investment advice of me",
          "ate my homework",
          "tried to seduce me",
          "ate my English Literature essay",
          "beat me into submission",
          "hid my Trapper Keeper",
          "stole my bicycle",
          "slept with my uncle",
          "slept with my aunt",
          "called me \"Too gay to fly a kite,\" whatever that means",
          "stole my identity",
          "broke into my house",
          "put me in a Chinese finger trap",
          "came after me",
          "came on to me",
          "came on me",
          "died while trying to tell me the lethal, killer joke",
          "text messaged racial slurs from my phone",
          "spin kicked me in the collar bone",
          "offered me a free Judo lesson",
          "tried to sell me a vacuum cleaner",
          "tried to sell me life insurance",
          "tried to sell me a reverse mortgage",
          "tried to sell me real estate investments in Mexico",
          "tried to sell me real estate investments on Pluto",
          "tried to sell me pork belly futures",
          "tried to feed me to a carnivorous plant",
          "crapped in my gas tank",
          "made me golf in shoes filled with macaroni and cheese",
          "pulled me over in a stolen police car and demanded fellatio",
          "made me find Jesus",
          "forced me to convert to Islam at gun point",
          "made me vote for Khodos",
          "made me vote for Khang",
          "made me vote for Donald Trump",
          "made me collect the cost of the wall from Mexico",
          "made me vote for Adolf Hitler",
          "made me vote for Lying-Ted Cruz",
          "made me vote for Hillary Clinton",
          "made me vote for Bernie Sanders",
          "kept telling me knock knock jokes"
         ]

  def initialize
    @head = []
    @mid  = []
    @tail = []
  end

  def excuse
    "#{next_head} #{next_mid} #{next_tail}."
  end

  private

  def next_head
    begin
      @head = HEAD.shuffle if @head.empty? || (rand(REMIX) == 0)
      result = @head.pop
    end until result != @last_head

    @last_head = result
  end

  def next_mid
    begin
      @mid = MID.shuffle if @mid.empty? || (rand(REMIX) == 0)
      result = @mid.pop
    end until result != @last_mid

    @last_mid = result
  end

  def next_tail
    begin
      @tail = TAIL.shuffle if @tail.empty? || (rand(REMIX) == 0)
      result = @tail.pop
    end until result != @last_tail

    @last_tail = result
  end

end


if __FILE__==$0
  excuse_generator = Excuse.new

  if (count = ARGV[0].to_i) <= 0
    count = 1
  end

  puts

  count.times do
    puts excuse_generator.excuse
  end

end




