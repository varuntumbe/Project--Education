from flask import Flask, jsonify, request
import json
app = Flask(__name__)
  
with open('test1.json','r') as myfile:
    data= myfile.read()
    myfile.close()

  
@app.route('/receive')
def send():
    return jsonify(data)

@app.route('/send', methods = ['POST'])
def receive():
    request_data = request.get_json()
    with open('newfile.json', 'w') as f:
        json.dump(request_data,f)
    return jsonify(request_data)

app.run(port=4000)
