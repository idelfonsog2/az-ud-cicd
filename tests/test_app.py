# filepath: /Users/idelfonso/Developer/az-ud-cicd/test_app.py
import pytest
import json
from flask import Flask
from app import app

@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

def test_home(client):
    """Test the home page"""
    rv = client.get('/')
    assert rv.status_code == 200
    assert b"Sklearn Prediction Home" in rv.data

def test_predict(client):
    """Test the predict endpoint"""
    # Sample payload for prediction
    payload = {
        "feature1": [1.0],
        "feature2": [2.0],
        "feature3": [3.0]
    }
    rv = client.post('/predict', json=payload)
    assert rv.status_code == 200
    response_data = json.loads(rv.data)
    assert 'prediction' in response_data

    