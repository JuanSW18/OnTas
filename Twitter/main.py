import tweepy
import requests
import json
from helper_firebase import Firebase

consumer_key = 'MY886YmO5XwdHV3x5mJV9VAJf'
consumer_secret = 'a6zK70ef0ckZD3qNXtIlIaHX2EGKdoyjN1NvsyUM6SaQKPoELc'
access_token = '43224556-qaD0x7W12yBUQnkrENyVOrHtnMhHStQ7vFXYMQux2'
access_token_secret = 'UyD06muwKTHp9yrEuavq1uTFp4XGiEGsn7Cx67jZhYl1X'

auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)

api = tweepy.API(auth)

class MyStreamListener(tweepy.StreamListener):
    def on_status(self, status):
        tweet = status
        if 'media' in tweet.entities:
            # only upload the first image
            image_url = tweet.entities['media'][0]['media_url']
            image = getImage(image_url)
            # response = store(image)
            response = {"uuid":"6bd615af-3873-4ae0-bfb5-14c1fe30cd2c"}
            toAnalize = response
            print("keys: ",toAnalize.keys())
            if 'uuid' in toAnalize.keys():
                back=Firebase().save_tweet(toAnalize['uuid'],"https://")
                print("back: ",back)
            print(response)
            print(response.content)
            print(toAnalize['uuid'])

myStreamListener = MyStreamListener()
myStream = tweepy.Stream(auth = api.auth, listener=myStreamListener)
myStream.filter(track=['pruebita'], is_async=True)


def getImage(url):
    # gets an image 
    response = requests.get(url)
    return response.content

def store(image):
    return requests.post('http://localhost:8080/upload', files={'data': image })
    
