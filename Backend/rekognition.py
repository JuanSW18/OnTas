import boto3

class Rekognition(object):

    def __init__(self):
        self.client = boto3.client('rekognition')
        self.collectionId = "lost"

    def index_faces(self,bytess,idImage):

        response = self.client.index_faces(
            Image={'Bytes': bytess}, CollectionId=self.collectionId, ExternalImageId=idImage)

        return response
