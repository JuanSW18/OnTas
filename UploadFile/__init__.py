import uuid, base64
from flask import Flask, request, abort, Response
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
<<<<<<< HEAD
	if request.method == 'POST':
		generated_file_name=str(uuid.uuid4())
		file = request.files['data']
		file.save('/home/danny/' + generated_file_name)

		return generated_file_name
		# image_bytes = base64.b64decode(bytes(file))
		# print(image_bytes)
		#file.save('/home/danny/' + secure_filename(generated_file_name))
		# return jsonify({ 'url': generated_file_name })

		#testing: curl -i -X POST -H "Content-Type: multipart/form-data" -F "data=@debian-rules.png" http://127.0.0.1:8080/upload
=======
        if request.method == 'POST':
                generated_file_name=str(uuid.uuid4())
                photo = request.files['data']
                imageBase64 = bytearray(photo.read())
                response = Rekognition().index_faces(imageBase64,generated_file_name)
                if is_valid_face(response): 
                        return json.dumps( {'uuid':response['FaceRecords'][0]['Face']['FaceId']} ) 
                else: return Response(json.dumps({"message":get_error(len(response['FaceRecords']))}), status=400, mimetype='application/json')
                

def is_valid_face(features):
        return True if len(features['FaceRecords'])==1 else False

def get_error(numberFace):
        return 'Esta imagen no contiene un rostro' if numberFace==0 else 'Esta imagen contiene más de 1 rostro'
>>>>>>> 017c657f15a53a2ea381eabc4af1765937790e58

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
        return True if len(features['FaceMatches'])>0 else False

def get_error(numberFace):
        return 'Esta imagen no contiene un rostro' if numberFace==0 else 'Esta imagen contiene más de 1 rostro'


def getURL(photo):
	response = aws.post(photo)
	return response.url


app.run(debug=False, port=8080)
#app.run()