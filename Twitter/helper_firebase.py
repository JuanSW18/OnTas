import firebase_admin
from firebase_admin import credentials,db

class Firebase(object):

    def __init__(self):
        print("goes here")
        self.cred = credentials.Certificate("ontas-aaff1-firebase-adminsdk-hfaid-143fbce3a6.json")
        self.default_app = firebase_admin.initialize_app(self.cred,
        {"databaseURL":"https://ontas-aaff1.firebaseio.com"})


    def save_tweet(self,uuid,url):

        print("-----------------------------------------------")
        ref=db.reference()
        print("ref:",ref)
        new_user = ref.child('lostperson').push(
            {
                uuid : {
                    "person" : {
                        "tweet" : url
                    }
                }
            }
        )
        
        return response
    