import uuid
import base64
from flask import Flask, jsonify
from flask import request
from flask import abort
from werkzeug.utils import secure_filename
from helper_aws import Rekognition
import json

app = Flask(__name__)

@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
        if request.method == 'POST':
                generated_file_name=str(uuid.uuid4())
                file = request.files['data']
                imageBase64 = bytearray(file.read())
                response = Rekognition().index_faces(imageBase64,generated_file_name)

                print("uuid: ",generated_file_name)

                if is_face(response): 
                        return json.dumps( {'uuid':generated_file_name} ) 
                else: return abort(400)
                
                        
		#return "hi :)"
		# image_bytes = base64.b64decode(bytes(file))
		# print(image_bytes)
		#file.save('/home/danny/' + secure_filename(generated_file_name))
		# return jsonify({ 'url': generated_file_name })

def is_face(features):
        return True if len(features['FaceRecords'])>0 else False

@app.route("/hola")
def index():
    return "Hola mundo"

app.run(debug=False, port=8080)