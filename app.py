import logging
import sys
from time import gmtime, strftime

def main():
	# Configure the logging system
	logging.basicConfig(filename ='/opt/results/app-log-branch3.txt', level = logging.INFO)
	
	# Variables (to make the calls that follow work)
	hostname = 'www.python.org'
	item = 'spam'
	filename = 'data.csv'
	mode = 'r'
	
	# Example logging calls (insert into your program)
	print("hello world branch3")
	logging.info("hello world branch3")
	logging.info(strftime("%Y-%m-%d %H:%M:%S", gmtime()))
	
if __name__ == '__main__':
	main()
sys.exit
