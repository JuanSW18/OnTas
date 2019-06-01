import boto3

class Rekognition(object):
    

    def __init__(self):
        self.collectionId = "lost"
        self.bucket_name = "hackathon.faces"

    def index_faces(self,imageBytes,idImage):

        client = boto3.client('rekognition')
        response = client.index_faces(
            Image={'Bytes': imageBytes}, CollectionId=self.collectionId, ExternalImageId=idImage)

        return response
    
    def face_recog(self,imageBytes):
        
        client = boto3.client('rekognition')
        response = client.search_faces_by_image(
            CollectionId=self.collectionId,
            Image={
                'Bytes': imageBytes
            },
            FaceMatchThreshold=80
        )
        
        return response
    
    def upload_file_to_s3(self,archive, name,acl="public-read"):

        client = boto3.client('s3')
        try:
            client.upload_fileobj(
                archive,
                self.bucket_name,
                name,
                ExtraArgs={
                    "ACL": acl,
                    "ContentType": archive.content_type
                }
            )

        except Exception as e:
            # This is a catch all exception, edit this part to fit your needs.
            print("Something Happened: ", e)
            return e

