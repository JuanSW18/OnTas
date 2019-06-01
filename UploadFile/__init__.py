import uuid, base64
from flask import Flask, request
from os import getcwd

app = Flask(__name__)

class Aws:
	def post(photo):
		return '123asdjasldlqdsq'

aws = Aws()


@app.route('/upload', methods=['GET', 'POST'])
def upload_file():
	if request.method == 'POST':
		generated_file_name=str(uuid.uuid4())
		file = request.files['data']
		imageBase64 = base64.b64encode(file.read())
		'''with open("./image64.txt", "wb") as f:
			f.write(imageBase64)
		return "hi :)"'''
		# image_bytes = base64.b64decode(bytes(file))
		# print(image_bytes)
		#file.save('/home/danny/' + secure_filename(generated_file_name))
		# return jsonify({ 'url': generated_file_name })

		#testing: curl -i -X POST -H "Content-Type: multipart/form-data" -F "data=@debian-rules.png" http://127.0.0.1:8080/upload

@app.route("/match", methods=['POST'])
def match():
	photo = request.files['data']
	return getURL(photo.read())

def getURL(photo):
	response = aws.post(photo)
	return response.url

@app.route("/hola")
def index():
    return "Hola mundo"


app.run(debug=False, port=8080)
#app.run()