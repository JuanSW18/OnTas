


class Config(object):
	DEBUG = False
	PORT = 3000

class ProductionConfig(Config):
	DEVELOPMENT = False