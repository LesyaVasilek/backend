from flask import Flask, request, jsonify
import os

app = Flask(__name__)

@app.route('/submit', methods=['POST'])
def submit_data():
    try:
        data = request.get_json()
        text = data.get('text', '')
        
        if not text:
            return jsonify({'error': 'No text provided'}), 400
        
        # Save to data.txt
        with open('data.txt', 'a', encoding='utf-8') as f:
            f.write(text + '\n')
        
        return jsonify({'message': 'Data saved successfully'}), 200
        
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
