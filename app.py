import os
from flask import Flask
app = Flask(_name_)

@app.route("/")
def main():
	os.system("deployment_tools/demo/demo_security_barrier_camera.sh -d CPU -sample-options -no_show")
	return "Welcome, inference is running"

@app.route('/how are you')
	return 'Inference is not running'

if __name__ == "__main__":
	app.run(host="0.0.0.0", port=8080)
