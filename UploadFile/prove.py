import uuid
from flask import Flask
from flask import jsonify
from flask import request
from werkzeug.utils import secure_filename

app = Flask(__name__)

@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
	if request.method == 'POST':
		generated_file_name=str(uuid.uuid4())
		file = request.files['data']
		file.save('/home/danny/' + secure_filename(generated_file_name))
		return jsonify({ 'url': generated_file_name })

@app.route("/hola")
def index():
    return "Hola mundo"
