import boto3

class Rekognition(object):

    def __init__(self):
s       self.client = boto3.client('rekognition')

    def index_faces(self,bytess,idImage):

        response = self.client.index_faces(
            Image={'Bytes': bytess}, CollectionId=self.collectionId, ExternalImageId=idImage)

        return response
