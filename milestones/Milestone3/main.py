# bot.py
# This file is intended to be a "getting started" code example for students.
# The code in this file is fully functional.
# Students are free to edit the code in the milestone 3 folder.
# Students are NOT allowed to distribute this code without the express permission of the class instructor
# IMPORTANT: How to set your secret environment variables? read README guidelines.

# imports
import os
import discord
import database as db
import commands
# environment variables
token = os.environ['DISCORD_TOKEN']
server = os.environ['DISCORD_GUILD']


# database connection
# secret keys related to your database must be updated. Otherwise, it won't work
db_conn = db.connect()
# bot events
intents = discord.Intents.default()
intents.message_content = True
client = discord.Client(intents=intents)

@client.event
async def on_ready():
    """
    This method triggers with the bot connects to the server
    Note that the sample implementation here only prints the
    welcome message on the IDE console, not on Discord
    :return: VOID
    """
    print("{} has joined the server".format(client.user.name))


@client.event
async def on_message(message):
    """
    This method triggers when a user sends a message in any of your Discord server channels
    :param message: the message from the user. Note that this message is passed automatically by the Discord API
    :return: VOID
    """
    response = None # will save the response from the bot
    if message.author == client.user:
        return # the message was sent by the bot
    if message.type is discord.MessageType.new_member:
        response = "Welcome {}".format(message.author) # a new member joined the server. Welcome him.
    else:
        # A message was send by the user.
        msg = message.content.lower()
        response = commands.response(msg)
        if "milestone3" in msg:
            response = "I am alive. Signed: 'your bot'"
    if response:
        # bot sends response to the Discord API and the response is show
        # on the channel from your Discord server that triggered this method.
        embed = discord.Embed(description=response)
        await message.channel.send(embed=embed)


try:
    # start the bot and keep the above methods listening for new events
    client.run(token)
except Exception as e:
    print(e)
