# importa l'API de Telegram
from telegram.ext import Updater, CommandHandler, MessageHandler, Filters
from antlr4 import *
from cl.SkylineLexer import SkylineLexer
from cl.SkylineParser import SkylineParser
from cl.EvalVisitor import EvalVisitor


# defineix una funció que saluda i que s'executarà quan el bot rebi el missatge /start
def start(update, context):
    username = update.effective_chat.username
    if 'userID' not in context.user_data:
        context.user_data['userID'] = username
    if 'skylines' not in context.user_data:
        context.user_data['skylines'] = {}
    missatge = "Benvingut a l'SkylineBot %s !\n\t Utilitza /help per més informació" % username
    context.bot.send_message(chat_id=update.effective_chat.id, text=missatge)


def ajuda(update, context):
    info = '''
*Ajuda*

Aqui pot trobar diferents comandes per coneixer el funcionament
    /definirSkyline
    /operacionsAmbSkylines
    /guardarICarregarSkylines
    '''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode='Markdown')


def definirSkyline(update, context):
    info = '''
*Definir un Skyline*
    
Hi ha diferents formes de definirlos, les seguents comandes especifiquen com es realitza cada un:
    /simple
    /compost
    /aleatori
'''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode="Markdown")


def simple(update, context):
    info = '''
*Definir un Skyline Simple*

Per a definir un skyline simple s'ha d'indicar un nom de variable que comenci amb una lletra o una lletra sola, seguit de la seguent estructura:

`:=` i a continuació s'indica el tamany de l'edifici de la seguent forma,`(xmin, alçada, xmax)`, on `xmin` i `xmax` indiquen les coordenades de inici i final de l'edifici.

Un exemple seria `a := (5,3,7)`.

En aquest cas crea un skyline amb l'identificador `a` amb un edifici situat a la coordenada 5 fins la 7 amb una altura de 2 unitats. 
'''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode="Markdown")


def compost(update, context):
    info = '''
*Definir un Skyline Compost*

Per a definir un skyline compost s'ha d'indicar un nom de variable que comenci amb una lletra o una lletra sola, seguit de la seguent estructura:

`:=` i a continuació s'introdueix una llista d'edificis amb el tamany de cada un indicat de la seguent forma.
`(xmin, alçada, xmax)`, on `xmin` i `xmax` indiquen les coordenades de inici i final de l'edifici.

Un exemple seria `a := [(5,3,7),(0,2,2),(7,5,8)]`.

En aquest cas crea un skyline amb l'identificador `a` amb tres edificis amb les seves coordenades i alçades corresponents. 
    '''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode="Markdown")


def aleatori(update, context):
    info = '''
*Definir un Skyline Aleatori*

Per a definir un skyline aleatori s'ha d'indicar un nom de variable que comenci amb una lletra o una lletra sola, seguit de la seguent estructura:

`:=` i a continuació de la seguent forma `{n, h, w, xmin, xmax}`. 
    - `n` indica la quantitat d'edificis que volem. 
    - `h` indica l'altura màxima que pot obtenir un edifici.
    - `w` indica l'amplada maxima que pot obtenir un edifici.
    - `xmin` indica la posició mínima que pot obtenir un edifici.
    - `xmax` indica la posició màxima que pot obtenir un edifici.
    
Un exemple seria `a := {10,20,8,0,60}`.
'''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode="Markdown")


def operacionsAmbSkylines(update, context):
    info = '''
*Operacions amb Skylines*

Aqui pot trobar diferents comandes per coneixer el funcionament de les diferents comandes:
    /unio
    /interseccio
    /replicacio
    /desplacament
    /reflexio
'''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode='Markdown')


def unio(update, context):
    info = '''
*Unió de dos Skylines*

Per a realitzar la unió de dos Skylines només cal posar al xat els seus identificadors amb el simbol `+` enmig.

Un exemple seria per a un skyline amb identificador `a` i un altre identificat amb b: `a + b`
_Es pot utilitzar juntament amb la igualació `:=` per a guardar el resultat_
'''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode='Markdown')


def interseccio(update, context):
    info = '''
*Intersecció de dos Skylines*

Per a realitzar la intersecció de dos Skylines només cal posar al xat els seus identificadors amb el simbol `*` enmig.

Un exemple seria per a un skyline amb identificador `a` i un altre identificat amb b: `a * b`
_Es pot utilitzar juntament amb la igualació `:=` per a guardar el resultat_
'''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode='Markdown')


def replicacio(update, context):
    info = '''
*Replicació d'un Skyline*

Per a realitzar la replicació d'un Skyline només cal posar al xat el seu identificador seguit del simbol `*` i a continuació el nombre de vegades que el volem replicar.

Un exemple seria per a un skyline amb identificador `a` i voler-lo replicar tres vegades: `a * 3`
_Es pot utilitzar juntament amb la igualació `:=` per a guardar el resultat_
'''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode='Markdown')


def desplacament(update, context):
    info = '''
*Desplaçament d'un Skyline*

Per a realitzar el desplaçament d'un Skyline només cal posar al xat el seu identificador seguit del simbol `+` o `-` i a continuació el nombre de unitats que el volem desplaçar.

Un exemple seria per a un skyline amb identificador `a` i voler-lo desplaçar a la dreta 3 unitats: `a + 3`
Un exemple seria per a un skyline amb identificador `a` i voler-lo desplaçar a la l'esquerra 8 unitats: `a - 8`
_Es pot utilitzar juntament amb la igualació `:=` per a guardar el resultat_
'''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode='Markdown')


def reflexio(update, context):
    info = '''
*Reflexió d'un Skyline*

Per a realitzar la reflexió d'un Skyline només cal posar al xat el simbol `-` i a continuació el seu identificador.

Un exemple seria per a un skyline amb identificador a: `- a`
_Es pot utilitzar juntament amb la igualació `:=` per a guardar el resultat_
    '''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode='Markdown')


def guardarICarregarSkylines(update, context):
    info = '''
*Guardar i carregar un Skyline*

Per a guardar un Skyline s'ha d'indicar al xat la comanda /save amb l'iendificador de l'Skyline: `/save a`

Per a carregar un Skyline que haviem guardat previament s'ha d'indicar en el xat amb la comanda /load amb l'identificador de l'skyline: `/load a`
'''
    context.bot.send_message(chat_id=update.effective_chat.id, text=info, parse_mode='Markdown')


def listVars(update, context):
    print("listVars")
    print(context.user_data['skylines'])
    for k, v in context.user_data['skylines'].items():
        msg = "var %d: %d" % (k, v)
        context.bot.send_message(chat_id=update.effective_chat.id, text=msg)


def commandManagement(update, context):
    missatge = update.message.text

    print(missatge)

    input_stream = InputStream(missatge)
    lexer = SkylineLexer(input_stream)
    token_stream = CommonTokenStream(lexer)
    parser = SkylineParser(token_stream)

    tree = parser.root()
    visitor = EvalVisitor(context.user_data['skylines'])

    actSkln = visitor.visit(tree)

    response(update, context, actSkln)


def response(update, context, actSkln):
    path = './fotos/' + str(context.user_data['userID']) + '.png'
    actSkln.createplot(path)
    context.bot.send_photo(chat_id=update.effective_chat.id, photo=open(path, 'rb'))


# declara una constant amb el access token que llegeix de token.txt
TOKEN = open('../Telegram_stuff/token.txt').read().strip()

# crea objectes per treballar amb Telegram
updater = Updater(token=TOKEN, use_context=True)
dispatcher = updater.dispatcher

# indica que quan el bot rebi la comanda /start s'executi la funció start
dispatcher.add_handler(CommandHandler('start', start))
dispatcher.add_handler(CommandHandler('help', ajuda))
dispatcher.add_handler(CommandHandler('definirSkyline', definirSkyline))
dispatcher.add_handler(CommandHandler('simple', simple))
dispatcher.add_handler(CommandHandler('compost', compost))
dispatcher.add_handler(CommandHandler('aleatori', aleatori))
dispatcher.add_handler(CommandHandler('operacionsAmbSkylines', operacionsAmbSkylines))
dispatcher.add_handler(CommandHandler('unio', unio))
dispatcher.add_handler(CommandHandler('interseccio', interseccio))
dispatcher.add_handler(CommandHandler('replicacio', replicacio))
dispatcher.add_handler(CommandHandler('desplacament', desplacament))
dispatcher.add_handler(CommandHandler('reflexio', reflexio))
dispatcher.add_handler(CommandHandler('guardarICarregarSkylines', guardarICarregarSkylines))
dispatcher.add_handler(CommandHandler('lst', listVars))
dispatcher.add_handler(MessageHandler(Filters.text, commandManagement))

# engega el bot
updater.start_polling()
