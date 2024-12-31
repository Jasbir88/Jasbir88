# src/authentication.py

def authenticate_user(username, password):
    if username == "admin" and password == "password":
        return "Authenticated"
    return "Authentication Failed"

