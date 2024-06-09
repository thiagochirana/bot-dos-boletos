from sqlobject import connectionForURI, sqlhub

import os


def init_db():
		sqlhub.processConnection = get_connection()


def create_tables():
		print("criando")
		# User.createTable(ifNotExists=True)
		# Wallet.createTable(ifNotExists=True)
		# TransactionHistory.createTable(ifNotExists=True)
		# BotBank.createTable(ifNotExists=True)
		# UserInteractions.createTable(ifNotExists=True)
		# UserInteractionsHistory.createTable(ifNotExists=True)
		# Evento.createTable(ifNotExists=True)
		# BettingHistory.createTable(ifNotExists=True)
		# BettingPayments.createTable(ifNotExists=True)


def open_transaction():
		con = get_connection()
		return con.transaction()


def get_connection():
		db_file = 'bot_dos_boletos.db'
		db_path = os.path.abspath(db_file)
		return connectionForURI(f'sqlite:///{db_path}')