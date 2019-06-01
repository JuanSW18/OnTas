from flask import Flask
from flask import jsonify
from flask import request
from werkzeug.utils import secure_filename

app = Flask(__name__)

@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        f = request.files['data']
        f.save('./' + secure_filename(f.filename))
        return "Hola"

@app.route("/hola")
def index():
    return "Hola mundo"
