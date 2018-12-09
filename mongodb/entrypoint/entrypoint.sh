# set -e

# mongo <<EOF
# var db = connect('mongodb://localhost/admin');
# db.auth('$ROOT_USERNAME', '$ROOT_PASSWORD');
# db = db.getSiblingDB('admin');
# db.createUser(
#     {
#         user: 'testuser',
#         pwd: 'testpassword123',
#         roles: [
#             {role: 'readAnyDatabase', db: 'admin'}
#         ]
#     }
# );
# EOF