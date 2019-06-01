import uuid, base64
from flask import Flask, request, abort
from os import getcwd
from helper_aws import Rekognition
import json

app = Flask(__name__)

class Aws:
	def post(photo):
		return '123asdjasldlqdsq'

aws = Aws()


@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
        if request.method == 'POST':
                generated_file_name=str(uuid.uuid4())
                photo = request.files['data']
                imageBase64 = bytearray(photo.read())
                response = Rekognition().index_faces(imageBase64,generated_file_name)
                if is_face(response): 
                        return json.dumps( {'uuid':generated_file_name} ) 
                else: return abort(400)
                

def is_face(features):
        return True if len(features['FaceRecords'])>0 else False

@app.route("/match", methods=['POST'])
def match():
	photo = request.files['data']
	return getURL(photo.read())

def getURL(photo):
	response = aws.post(photo)
	return response.url


app.run(debug=False, port=8080)
#app.run()