import random
import datetime
from flask import Flask, render_template
app = Flask(__name__, template_folder="web", static_url_path='')

jokes = {
    "You know why you never see elephants hiding up in trees?" : "Because they’re really good at it.",
    "What is red and smells like blue paint?": "Red paint.",
    "Where does the General keep his armies?": "In his sleevies!",
    "Why aren’t koalas actual bears?": "The don’t meet the koalafications.",
    "A bear walks into a restaurant and say’s I want a grilllllled………………………………………cheese. The waiter says Whats with the pause?": "The bear replies What do you mean, I'm a Bear!",
    "What do you call bears with no ears?": "B",
    'I went in to a pet shop. I said, “Can I buy a goldfish?” The guy said, “Do you want an aquarium?”' : 'I said, “I don’t care what star sign it is.”',
    'I saw a wino eating grapes.': 'I told him, you gotta wait.',
    'What’s brown and sticky?': 'A stick.',
    'What does a pepper do when it’s angry?': 'It gets jalapeño face!',
    'What’s a foot long and slippery?': 'A slipper.',
    'Two gold fish are in a tank.': 'One looks at the other and says, “You know how to drive this thing?!”',
    'Two soldiers are in a tank.': 'One looks at the other and says, “BLUBLUBBLUBLUBBLUB.”',
    'As a scarecrow, people say I’m outstanding in my field.': 'But hay, it’s in my jeans.',
    'What is the resemblance between a green apple and a red apple?': 'They’re both red except for the green one.',
    'I have an EpiPen.': 'My friend gave it to me when he was dying, it seemed very important to him that I have it.',
    'How did the hipster burn his mouth?': 'He ate the pizza before it was cool.',
    'An atheist, a Crossfitter, and a vegan walk into a bar.': 'I know because they told me.',
    'I waited and stayed up all night and tried to figure out where the sun was.': 'Then it dawned on me.',
    'I told my friend 10 jokes to get him to laugh.': 'Sadly, no pun in 10 did.',
    'What’s red and moves up and down?': 'A tomato in an elevator',
    'I bought the world’s worst thesaurus yesterday.': 'Not only is it terrible, it’s terrible.',
    'Why can’t you hear a pterodactyl go to the bathroom?': 'Because the “P” is silent!',
    'How did the blonde die ice fishing?': 'She was hit by the zamboni.',
    'How does NASA organize a party?': 'They planet.',
    'What’s a pirates favorite letter?': 'You think it’s R but it be the C.',
    'Have you heard about corduroy pillows?': 'They’re making headlines.',
    'What did the green grape say to the purple grape?': 'OMG!!!!!!! BREATHE!! BREATHEEEEE!!!!!',
    'Never criticize someone until you have walked a mile in their shoes.': 'That way, when you criticize them, you’ll be a mile away, and you’ll have their shoes.',
    'What do Alexander the Great and Winnie the Pooh have in common?': 'Same middle name.',
    'I couldn’t believe that the highway department called my dad a thief.': 'But when I got home, all the signs were there.',
    'What did the left eye say to the right eye?': 'Between you and me, something smells.',
    'What do Cannon Balls do when they’re in love?': 'Make bbs.',
    'Sometimes I tuck my knees into my chest and lean forward.': 'That’s just how I roll.',
    'I intend to live forever.': 'So far, so good',
    "What's green and has wheels": "Grass, I was just kidding about the wheels",
    "I went to the zoo yesterday and saw a baguette in a cage" : "The zookeeper told me it was bread in captivity"
}

@app.route('/')
def index():
   return render_template('index.html')

@app.route('/jokes')
def get_joke():
    today = str(datetime.date.today())
    random.seed(today)
    joke = random.choice(list(jokes))
    answer = jokes[joke]
    return joke + "|" + answer

@app.route('/main.js')
def send_js():
    return render_template('main.js')

@app.route('/style.css')
def send_css():
    print("hello")
    return render_template('style.css')

app.run('0.0.0.0', 8080)
