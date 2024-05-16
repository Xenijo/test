import discord
import requests
import json
from discord.ext import tasks, commands
import logging

# Setup logging
logging.basicConfig(level=logging.DEBUG)

# Replace with your bot's token
TOKEN = 'MTIzODQyOTc2NTUxNDU1OTUwOQ.GmKaEA.xEfjAVpPoYohR8vA3G7PGpWPkZ5DZ1iR4KKksw'

def get_roblox_client_versions():
    urls = {
        "windows": "https://setup.rbxcdn.com/version",
    }

    versions = {}
    for platform, url in urls.items():
        try:
            response = requests.get(url)
            response.raise_for_status()
            versions[platform] = response.text.strip()
        except requests.RequestException as e:
            versions[platform] = f"Error: {e}"
    
    return versions

def load_settings():
    try:
        with open('settings.json', 'r') as f:
            settings = json.load(f)
            # Initialize versions if not available
            if 'versions' not in settings:
                settings['versions'] = get_roblox_client_versions()
            return settings
    except FileNotFoundError:
        return {"channel_id": None, "versions": get_roblox_client_versions()}

def save_settings(settings):
    with open('settings.json', 'w') as f:
        json.dump(settings, f)

# Load settings on bot start
settings = load_settings()
CHANNEL_ID = settings.get('channel_id')
previous_versions = settings.get('versions')

# Define function to reload settings
def reload_settings():
    global settings, CHANNEL_ID, previous_versions
    settings = load_settings()
    CHANNEL_ID = settings.get('channel_id')
    previous_versions = settings.get('versions')

# Create bot instance
intents = discord.Intents.all()
bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    logging.info(f'Bot is ready. Logged in as {bot.user}')
    check_versions.start()

@bot.command(name='reloadsettings')
@commands.has_permissions(administrator=True)
async def reload_settings_command(ctx):
    reload_settings()
    await ctx.send("Settings reloaded!")

@bot.command(name='setchannel')
@commands.has_permissions(administrator=True)
async def set_channel(ctx):
    global CHANNEL_ID
    CHANNEL_ID = ctx.channel.id  # Get the ID of the channel where the command was run
    settings['channel_id'] = CHANNEL_ID
    save_settings(settings)
    await ctx.send(f'Channel for updates set to <#{CHANNEL_ID}>')
    logging.info(f'Channel for updates set to: {CHANNEL_ID}')

@tasks.loop(seconds=30)
async def check_versions():
    global previous_versions, settings
    # Reload settings every loop iteration
    reload_settings()
    current_versions = get_roblox_client_versions()
    
    if CHANNEL_ID:
        channel = bot.get_channel(CHANNEL_ID)
        if channel:
            if current_versions.get("windows") != previous_versions.get("windows"):
                embed = discord.Embed(
                    title="Windows Client Version Changed",
                    color=discord.Color.red()  # Change color to red
                )
                embed.description = "@everyone Roblox Updated"  # Ping everyone
                embed.add_field(name="New Version", value=current_versions["windows"], inline=False)
                embed.add_field(name="Old Version", value=previous_versions["windows"], inline=False)
                await channel.send(embed=embed)
                previous_versions["windows"] = current_versions["windows"]
                settings['versions']['windows'] = current_versions["windows"]  # Update version in settings
                logging.debug(f"Version changed: Windows - New: {current_versions['windows']} | Old: {previous_versions['windows']}")
                save_settings(settings)  # Update JSON file with new version
        else:
            logging.warning(f"Channel ID {CHANNEL_ID} is not valid.")

@bot.command(name='checkversion')
async def check_version(ctx):
    current_versions = get_roblox_client_versions()
    embed = discord.Embed(title="Roblox Client Version Check", color=discord.Color.green())
    
    for platform in current_versions:
        embed.add_field(name=f"{platform.capitalize()} Current Version", value=current_versions[platform], inline=False)
    
    await ctx.send(embed=embed)

# Run the bot
bot.run(TOKEN)
