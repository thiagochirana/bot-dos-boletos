import discord
from discord import app_commands
from discord.ext import commands as com
import src.functionalities.log as LOG
import src.functionalities.messages as message


class GastoCommands(com.Cog):
		
		def __init__(self, bot):
				self.bot = bot
				self.bot.tree.add_command(self.evento)
		
		evento = app_commands.Group(name="gasto", description="Gerencie seus gastos")
		
		@evento.command(name='criar', description="Crie um evento")
		@app_commands.describe(titulo="Titulo do Evento", opcao_a="Nome da opção",
		                       opcao_b="Nome da opção")
		async def create(self, interaction: discord.Interaction, titulo: str, opcao_a: str, opcao_b: str):
				# evt = evento_service.create_event(interaction, titulo, categoria, opcao_a, opcao_b)
				# await message.announce_event(interaction, evt)
				msg =  message.gen_embed_message(
						title="Testano",
						description=f" {titulo} {opcao_a} {opcao_b}",
						color=discord.Color.green()
				)
				await message.send_embed_msg(interaction, msg)
		
		# @bet_on_the_event.autocomplete('opcao')
		# async def _opcoes(self, interaction: discord.Interaction, current: str):
		# 		options = [
		# 				app_commands.Choice(name="A", value="A"),
		# 				app_commands.Choice(name="B", value="B"),
		# 		]
		# 		return [choice for choice in options if current.lower() in choice.name.lower()]
		#
		# @create.autocomplete('categoria')
		# async def _list_categories(self, interaction: discord.Interaction, current: str):
		# 		return [
		# 				app_commands.Choice(name=category.value, value=category.name)
		# 				for category in Category
		# 				if current.lower() in category.value.lower()
		# 		]
