# src/authentication.py

import bcrypt

# Example user data, in a real application this would come from a database
USER_DATA = {
    "admin": bcrypt.hashpw("password".encode(), bcrypt.gensalt()).decode()  # Hash for "password"
}


def hash_password(password):
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()


def authenticate_user(username, password):
    stored_password = USER_DATA.get(username)
    if stored_password and bcrypt.checkpw(password.encode(), stored_password.encode()):
        return "Authenticated"
    return "Authentication Failed"
