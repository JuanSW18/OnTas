import uuid
import base64
from flask import Flask, jsonify
from flask import request
from werkzeug.utils import secure_filename

app = Flask(__name__)

@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
	if request.method == 'POST':
		generated_file_name=str(uuid.uuid4())
		file = request.files['data']
		imageBase64 = base64.b64encode(file.read())
		with open("./image64.txt", "wb") as f:
			f.write(imageBase64)
		return "hi :)"
		# image_bytes = base64.b64decode(bytes(file))
		# print(image_bytes)
		#file.save('/home/danny/' + secure_filename(generated_file_name))
		# return jsonify({ 'url': generated_file_name })

@app.route("/hola")
def index():
    return "Hola mundo"

app.run(debug=False, port=8080)