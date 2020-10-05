import os
from flask import Flask
app = Flask(__name__)

@app.route("/")
def main():
	os.system("deployment_tools/demo/demo_security_barrier_camera.sh -d CPU -sample-options -no_show")
	return "Welcome, inference is running"

@app.route('/dont run')
def hello():
	return 'Inference is not running'

if __name__ == "__main__":
	app.run(host="0.0.0.0", port=8080)
