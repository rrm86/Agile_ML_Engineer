from app import app
import pytest
import json


@pytest.fixture
def client():
    app.config['TESTING'] = True
    client = app.test_client()

    yield client

def test_predict(client):
    'Testing the function'
    data = {
        'CHAS':{"0":4.98},
        'RM': {"0":4.98},
        'TAX': {"0":4.98},
        'PTRATIO':{"0":4.98},
        'B':{"0":4.98},
        'LSTAT':{"0":4.98}
    }
    url = '/predict'
    response = client.post(url, json=data )
    assert response.status_code == 200
    assert 'prediction' in response.get_json()