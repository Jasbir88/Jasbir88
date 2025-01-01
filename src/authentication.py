# src/authentication.py

import hashlib
import hmac

# Example user data, in a real application this would come from a database
USER_DATA = {
    "admin": "5f4dcc3b5aa765d61d8327deb882cf99"  # This is the MD5 hash for "password"
}

def hash_password(password):
    return hashlib.md5(password.encode()).hexdigest()

def authenticate_user(username, password):
    hashed_password = hash_password(password)
    stored_password = USER_DATA.get(username)
    if stored_password and hmac.compare_digest(stored_password, hashed_password):
        return "Authenticated"
    return "Authentication Failed"

