from app import home


def test_home():
    response = home()
    assert  response.isprintable