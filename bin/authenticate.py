import os

from keystoneclient.v3 import client


HOST = os.environ.get('HOST', '23.253.157.126')
KEYSTONE_ENDPOINT = os.environ.get(
    'KEYSTONE_ENDPOINT', 'http://%s:35357/' % HOST)


project_scoped = client.Client(
    username='admin',
    password='password',
    project_name='admin',
    auth_url=KEYSTONE_ENDPOINT + 'v3')
print('%s' % project_scoped.auth_token)
