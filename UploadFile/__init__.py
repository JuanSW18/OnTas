import uuid, base64
from flask import Flask, request, abort, Response
from os import getcwd
from helper_aws import Rekognition
import json

app = Flask(__name__)

@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
        if request.method == 'POST':
                generated_file_name=str(uuid.uuid4())
                photo = request.files['data']
                imageBase64 = bytearray(photo.read())
                response = Rekognition().index_faces(imageBase64,generated_file_name)
                if is_valid_face(response): 
                        return json.dumps( {'uuid':response['FaceRecords'][0]['Face']['FaceId']} ) 
                else: return Response(json.dumps({"message":get_error(len(response['FaceRecords']))}), status=400, mimetype='application/json')
                

def is_valid_face(features):
        return len(features['FaceRecords'])==1

def get_error(numberFace):
        return 'Esta imagen no contiene un rostro' if numberFace==0 else 'Esta imagen contiene más de 1 rostro'

@app.route("/match", methods=['POST'])
def match():
	photo = request.files['data']
	imageBase64 = bytearray(photo.read())
	response = Rekognition().face_recog(imageBase64)
	if is_match(response):
			return json.dumps( {
				'uuid':response['FaceMatches'][0]['Face']['FaceId'],
				'similarity':response['FaceMatches'][0]['Similarity']
				} ) 
	else:
			return Response(json.dumps({"message":"No se encontro match"}), status=400, mimetype='application/json')

def is_match(features):
        return len(features['FaceMatches'])>0

def getURL(photo):
	response = aws.post(photo)
	return response.url


app.run(debug=False, port=8080)